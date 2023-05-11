//
//  AddRefuelView.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 27/04/2023.
//

import SwiftUI
import CoreLocationUI
import MapKit

struct AddRefuelView: View {
    @ObservedObject var locationManager = LocationManager()
    @ObservedObject var viewModel: AddRefuelViewModel
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var carDataSource: CarDataSource

    @State var pin: [Location] = []

    var body: some View {
        ScrollView {
            ZStack {
                Color.ui.background
                    .ignoresSafeArea()
                VStack {
                    TitleAndTextField(title: "mileage",
                                      textFieldValue: $viewModel.mileage)
                    TitleAndTextField(title: "fuel.amount",
                                      textFieldValue: $viewModel.fuelAmount)
                    TitleAndTextField(title: "cost.per.unit",
                                      textFieldValue: $viewModel.costPerUnit)

                    DatePicker("date", selection: $viewModel.date, displayedComponents: [.date])
                        .tint(Color.ui.action)
                        .datePickerStyle(.graphical)
                    if let region = $locationManager.region,
                       region.wrappedValue != nil {
                        Map(coordinateRegion: region.toUnwrapped(defaultValue: .init(.world)),
                            showsUserLocation: true,
                            annotationItems: pin) {
                            MapMarker(coordinate: .init(latitude: $0.latitude,
                                                     longitude: $0.longitude))
                        }
                            .frame(height: 300)
                            .cornerRadius(8)
                            .padding()
                    }
                    Spacer()

                    LocationButton(.shareMyCurrentLocation) {
                        locationManager.requestLocation()
                        pin.removeAll()
                        pin.append(.init(latitude: locationManager.location?.latitude ?? 0,
                                         longitude: locationManager.location?.longitude ?? 0))
                    }
                    .cornerRadius(8)
                    .frame(height: 44)
                    .foregroundColor(.white)
                    .padding()

                    NavigationLink(destination: LocationSelectionView { coordinate in
                        locationManager.location = coordinate
                        viewModel.usersLocation = coordinate
                        pin.removeAll()
                        pin.append(.init(latitude: coordinate.latitude,
                                         longitude: coordinate.longitude))
                    }) {
                        Text("open.map")
                    }

                    Button {
                        viewModel.usersLocation = locationManager.location
                        viewModel.addRefuel()
                        Cache.shared.invalidate(key: "cars")
                        Task {
                            try await carDataSource.getCars()
                        }
                        dismiss()
                    } label: {
                        Spacer()
                        Text("add")
                        Spacer()
                    }
                    .tint(Color.ui.action)
                    .buttonStyle(.borderedProminent)
                    .padding()
                }
            }
            .onAppear {
                locationManager.requestLocation()
            }
            .padding()
        }
    }
}

struct AddRefuelView_Previews: PreviewProvider {
    static var previews: some View {
        AddRefuelView(viewModel: .init(service: RefuelService(),
                                       car: .constant(Car.mock)))
    }
}
