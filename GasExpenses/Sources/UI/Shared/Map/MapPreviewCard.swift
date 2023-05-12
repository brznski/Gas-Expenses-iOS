//
//  MapPreviewCard.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 12/05/2023.
//

import SwiftUI
import MapKit
import CoreLocationUI
import CoreLocation

struct MapPreviewCard: View {
    @ObservedObject var locationManager = LocationManager()

    @State private var pin: [Location] = []

    let locationChanged: (Location) -> Void

    init(locationChanged: @escaping (Location) -> Void) {
        self.locationChanged = locationChanged
    }

    init(region: MKCoordinateRegion,
         locationChanged: @escaping (Location) -> Void) {
        self.locationChanged = locationChanged
        locationManager.region = region
        pin.append(.init(latitude: region.center.latitude,
                         longitude: region.center.longitude))
    }

    var body: some View {
        CardWithTitleView(title: LocalizedStringKey("map")) {
            VStack {
                if let region = $locationManager.region.wrappedValue {
                    Map(coordinateRegion: .constant(region), annotationItems: pin) { location in
                        MapAnnotation(coordinate: .init(latitude: location.latitude, longitude: location.longitude)) {
                            Text("123")
                        }
                    }
                    .padding()
                    .frame(minHeight: 300)
                    .cornerRadius(8)
                }
                VStack {
                    ButtonPrimary {
                        Label("curent.position",
                              systemImage: "location")
                    } action: {
                        locationManager.requestLocation()
                        pin.removeAll()
                        pin.append(.init(latitude: locationManager.location?.latitude ?? 0,
                                         longitude: locationManager.location?.longitude ?? 0))
                    }
                    .padding(.horizontal)

                    NavigationLink(destination: LocationSelectionView { coordinate in
                        locationManager.location = coordinate
                        pin.removeAll()
                        pin.append(.init(latitude: coordinate.latitude,
                                         longitude: coordinate.longitude))
                    }) {
                        Spacer()
                        Label("open.map", systemImage: "map")
                        Spacer()
                    }
                    .buttonStyle(.borderedProminent)
                    .padding([.horizontal, .bottom])
                }
            }
        }
    }
}

struct MapPreviewCard_Previews: PreviewProvider {
    static var previews: some View {
        MapPreviewCard { _ in }
    }
}
