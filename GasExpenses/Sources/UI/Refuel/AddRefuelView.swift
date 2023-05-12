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
            MapPreviewCard { _ in }
            ImagePreviewCard(imageData: $viewModel.documentBase64)

            if let documentPhotoData = $viewModel.documentBase64.wrappedValue {
                Image(uiImage: .init(data: documentPhotoData)!)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(8)
            }

            ButtonPrimary {
                Text("add")
            } action: {
                viewModel.usersLocation = locationManager.location
                viewModel.addRefuel()
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
        AddRefuelView(viewModel: .init(service: RefuelService(),
                                       car: .constant(Car.mock)))
    }
}
