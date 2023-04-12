//
//  AddCarView.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 12/04/2023.
//

import SwiftUI

struct AddCarView: View {
    @State var carName: String = ""
    @State var carBrand: String = ""
    @State var carModel: String = ""
    @State var carMileage: String = ""
    @ObservedObject var viewModel: AddCarViewModel = .init()

    var body: some View {
        ScrollView {
            CardWithTitleView(title: "Car info") {
                VStack {
                    TextField("Car name",
                              text: $carName)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    TextField("Brand",
                              text: $carBrand)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    TextField("Model",
                              text: $carModel)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    TextField("Mileage",
                              text: $carMileage)
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
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

                    VStack {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding()
                        Text("Add car photo")
                            .padding()
                    }
                    .background(RoundedRectangle(cornerRadius: 8)
                        .stroke(lineWidth: 3))
                    .padding()

            Button {

            } label: {
                Text("Add")
            }
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
