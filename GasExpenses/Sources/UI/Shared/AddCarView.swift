//
//  AddCarView.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 12/04/2023.
//

import SwiftUI
import PhotosUI

struct AddCarView: View {
    @State var carName: String = ""
    @State var carBrand: String = ""
    @State var carModel: String = ""
    @State var carMileage: String = ""
    @State var carFuelType: String = ""

    @ObservedObject var viewModel: AddCarViewModel = .init()
    @Environment(\.dismiss) var dismiss

    @State private var selectedPhoto: PhotosPickerItem?
    @State private var selectedImageData: Data?

    var body: some View {
        ScrollView {
            CardWithTitleView(title: "Car info") {
                VStack {

                    PhotosPicker(
                        selection: $selectedPhoto,
                        matching: .images,
                        photoLibrary: .shared()) {
                            if let selectedImageData,
                            let uiImage = UIImage(data: selectedImageData) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    .padding()
                            } else {
                                Text("select.photo")
                            }
                        }
                        .onChange(of: selectedPhoto) { newItem in
                            Task {
                                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                    selectedImageData = data
                                }
                            }
                        }

                    Group {
                        TitleAndTextField(title: "car.name",
                                          textFieldValue: $carName)
                        TitleAndTextField(title: "brand",
                                          textFieldValue: $carBrand)
                        TitleAndTextField(title: "model",
                                          textFieldValue: $carModel)
                        TitleAndTextField(title: "mileage",
                                          textFieldValue: $carMileage)
                        .keyboardType(.decimalPad)
                        TitleAndTextField(title: "car.name",
                                          textFieldValue: $carName)
                    }
                    .padding()

                    HStack {
                        Text("fuel.type")
                            .padding()
                        Spacer()
                        Picker(selection: $carFuelType, label: EmptyView()) {
                            ForEach(FuelTypes.allCases) {
                                Text($0.rawValue).tag($0.rawValue)
                            }
                        }
                        .pickerStyle(.menu)
                        .tint(Color.ui.action)
                        .padding()
                    }
                }
            }

            Button {
                Task {
                    try await CarService().addCar(.init(id: 0,
                                                        name: carName,
                                                        brand: carBrand,
                                                        model: carModel,
                                                        refuels: [],
                                                        fuelType: FuelTypes(rawValue: carFuelType) ?? FuelTypes.pb95,
                                                        isFavourite: false,
                                                        imageBase64: selectedImageData?.base64EncodedString() ?? ""))
                    dismiss()
                }
            } label: {
                Spacer()
                Text("add")
                Spacer()
            }
            .padding()
            .buttonStyle(.borderedProminent)
            .tint(Color.ui.action)

        }
        .background(Color.ui.background)
    }
}

struct AddCarView_Previews: PreviewProvider {
    static var previews: some View {
        AddCarView()
    }
}
