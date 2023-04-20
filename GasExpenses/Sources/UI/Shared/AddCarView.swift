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
    @ObservedObject var viewModel: AddCarViewModel = .init()
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var selectedImageData: Data? = nil

    var body: some View {
        ScrollView {
            CardWithTitleView(title: "Car info") {
                VStack {

                    PhotosPicker(
                        selection: $selectedPhoto,
                        matching: .images,
                        photoLibrary: .shared()) {
                            if let selectedImageData,
                            let uiImage = UIImage(data: selectedImageData){
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    .padding()
                            } else {
                                Text("Select a photo")
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
                        TitleAndTextField(title: "Car name",
                                          textFieldValue: $carName)
                        TitleAndTextField(title: "Brand",
                                          textFieldValue: $carBrand)
                        TitleAndTextField(title: "Model",
                                          textFieldValue: $carModel)
                        TitleAndTextField(title: "Mileage",
                                          textFieldValue: $carMileage)
                        .keyboardType(.decimalPad)
                        TitleAndTextField(title: "Car name",
                                          textFieldValue: $carName)
                    }
                    .padding()

                    HStack {
                        Text("Fuel Type")
                            .padding()
                        Spacer()
                        Picker(selection: $carBrand, label: EmptyView()) {
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

            } label: {
                Spacer()
                Text("Add")
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
