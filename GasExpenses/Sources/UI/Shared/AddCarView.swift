//
//  AddCarView.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 12/04/2023.
//

import SwiftUI

struct AddCarView: View {
    @ObservedObject var viewModel: AddCarViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Color.ui.background
                .ignoresSafeArea()
            ScrollView {
                CardWithTitleView(title: "car.info") {
                    VStack {
                        Group {
                            TitleAndTextField(title: "car.name",
                                              textFieldValue: $viewModel.carName)
                            TitleAndTextField(title: "brand",
                                              textFieldValue: $viewModel.carBrand)
                            TitleAndTextField(title: "model",
                                              textFieldValue: $viewModel.carModel)
                        }

                        HStack {
                            Text("fuel.type")
                            Spacer()
                            Picker(selection: $viewModel.carFuelType, label: EmptyView()) {
                                ForEach(FuelTypes.allCases) {
                                    Text($0.rawValue).tag($0.rawValue)
                                }
                            }
                            .pickerStyle(.menu)
                            .tint(Color.ui.action)
                        }

                        DatePicker("insurance.expiration",
                                   selection: $viewModel.insuranceExpiration.toUnwrapped(defaultValue: .now), displayedComponents: [.date])
                        DatePicker("technical.checkup.expiration",
                                   selection: $viewModel.technicalCheckupExpiration.toUnwrapped(defaultValue: .now), displayedComponents: [.date])
                    }
                    .padding()
                }

                ImagePreviewCard(imageData: $viewModel.imageData,
                                 cardContext: .edit)

                ButtonPrimary {
                    Text(viewModel.getSubmitButtonText())
                } action: {
                    viewModel.submit { dismiss() }
                }
                .padding()
            }
        }
        .background(Color.ui.background)
    }
}

struct AddCarView_Previews: PreviewProvider {
    static var previews: some View {
        AddCarView(viewModel: .init(carService: ServiceLocator.shared.getCarService()))
    }
}
