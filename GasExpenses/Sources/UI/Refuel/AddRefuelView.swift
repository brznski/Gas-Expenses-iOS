//
//  AddRefuelView.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 27/04/2023.
//

import SwiftUI
import CoreLocation
import CoreLocationUI
import MapKit

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()

    @Published var location: CLLocationCoordinate2D? {
        didSet {
            if let location {
                region = .init(center: location,
                               latitudinalMeters: 700,
                               longitudinalMeters: 700)
            }
        }
    }
    @Published var region: MKCoordinateRegion?

    override init() {
        super.init()
        manager.delegate = self
    }

    func requestLocation() {
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
        if let location {
            region = .init(center: location,
                           latitudinalMeters: 700,
                           longitudinalMeters: 700)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

final class AddRefuelViewModel: ObservableObject {
    @Published var date: Date = .now
    @Published var mileage: String = ""
    @Published var fuelAmount: String = ""
    @Published var costPerUnit: String = ""
    @Published var usersLocation: CLLocationCoordinate2D?

    @Binding var car: Car?
    private let service: RefuelServiceProtocol

    init(service: RefuelServiceProtocol,
         car: Binding<Car?>) {
        self.service = service
        self._car = car
    }

    func addRefuel() {
        Task {
            let newRefuel = Refuel(id: 0,
                                   date: date.JSONDate(),
                                   mileage: Double(mileage)!,
                                   fuelAmount: Double(fuelAmount)!,
                                   costPerUnit: Double(costPerUnit)!,
                                   latitude: (usersLocation?.latitude.magnitude)!,
                                   longitude: (usersLocation?.longitude.magnitude)!)
            do {
                try await service.addRefuel(newRefuel,
                                            carID: car?.id ?? -1)
            } catch {

            }
        }
    }
}

struct AddRefuelView: View {
    @ObservedObject var locationManager = LocationManager()
    @ObservedObject var viewModel: AddRefuelViewModel
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var carDataSource: CarDataSource

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
                            showsUserLocation: true)
                            .frame(height: 300)
                            .cornerRadius(8)
                            .padding()
                    }
                    Spacer()

                    LocationButton(.shareMyCurrentLocation) {
                        locationManager.requestLocation()
                    }
                    .cornerRadius(8)
                    .frame(height: 44)
                    .foregroundColor(.white)
                    .padding()

                    NavigationLink(destination: LocationSelectionView(onSelectedLocalization: { coordinate in
                        locationManager.location = coordinate
                    })) {
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
        AddRefuelView(viewModel: .init(service: RefuelService(), car: .constant(Car(id: 0,
                                                                                    name: "",
                                                                                    brand: "",
                                                                                    model: "",
                                                                                    refuels: [],
                                                                                    fuelType: .pb95,
                                                                                    isFavourite: false,
                                                                                    imageBase64: ""))))
    }
}
