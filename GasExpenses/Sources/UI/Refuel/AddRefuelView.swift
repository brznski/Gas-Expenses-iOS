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

    init(viewModel: AddRefuelViewModel) {
        self.viewModel = viewModel
    }

    init(viewModel: AddRefuelViewModel,
         refuel: Refuel) {
        self.viewModel = viewModel

        viewModel.refuelID = refuel.id
        viewModel.title = refuel.title
        viewModel.comment = refuel.title
        viewModel.mileage = "\(refuel.mileage)"
        viewModel.fuelAmount = "\(refuel.fuelAmount)"
        viewModel.costPerUnit = "\(refuel.costPerUnit)"
        viewModel.date = refuel.date.dateFromJSON() ?? .now

        if let latitude = refuel.latitude,
           let longitude = refuel.longitude {
            viewModel.usersLocation = .init(latitude: latitude,
                                            longitude: longitude)
        }

        if let imageBase64 = refuel.documentBase64,
           !imageBase64.isEmpty,
           let imageData = Data(base64Encoded: imageBase64) {
            viewModel.documentBase64 = imageData
        }
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            CardWithTitleView(title: "main.form") {
                VStack {
                    TitleAndTextField(title: "title",
                                      textFieldValue: $viewModel.title,
                                      keyboardType: .asciiCapable)
                    TitleAndTextField(title: "comment",
                                      textFieldValue: $viewModel.comment,
                                      keyboardType: .asciiCapable)
                    TitleAndTextField(title: "mileage",
                                      textFieldValue: $viewModel.mileage,
                                      keyboardType: .numberPad)
                    TitleAndTextField(title: "fuel.amount",
                                      textFieldValue: $viewModel.fuelAmount,
                                      keyboardType: .decimalPad)
                    TitleAndTextField(title: "cost.per.unit",
                                      textFieldValue: $viewModel.costPerUnit,
                                      keyboardType: .decimalPad)
                    DatePicker("date", selection: $viewModel.date, displayedComponents: [.date])
                        .tint(Color.ui.action)
                        .datePickerStyle(.compact)
                }
                .padding()
            }

            if let latitude = viewModel.usersLocation?.latitude,
               let longitude = viewModel.usersLocation?.longitude {
                MapPreviewCard(cardContext: .edit,
                               region: .init(center: .init(latitude: latitude, longitude: longitude),
                                             latitudinalMeters: 700,
                                             longitudinalMeters: 700)) { location in
                    viewModel.usersLocation?.longitude = location.longitude
                    viewModel.usersLocation?.latitude = location.latitude
                }
            } else {
                MapPreviewCard(cardContext: .edit) {
                    viewModel.usersLocation?.longitude = $0.longitude
                    viewModel.usersLocation?.latitude = $0.latitude
                }
            }

            ImagePreviewCard(imageData: $viewModel.documentBase64,
                             cardContext: .edit)

            ButtonPrimary {
                Text("add")
            } action: {
                viewModel.usersLocation = locationManager.location
//                viewModel.addRefuel()
                Task {
                    await viewModel.editRefuel()
                }
                Cache.shared.invalidate(key: "cars")
                Task {
                    try await carDataSource.getCars()
                }
                dismiss()
            }
            .padding()
        }
        .onAppear {
            locationManager.requestLocation()
        }
        .background {
            Color.ui.background
                .ignoresSafeArea()
        }
    }
}

struct AddRefuelView_Previews: PreviewProvider {
    static var previews: some View {
        AddRefuelView(viewModel: .init(service: ServiceLocator.shared.getRefuelService(),
                                       carID: 0))
    }
}
