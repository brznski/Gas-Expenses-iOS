//
//  CarRowInfoView.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 13/04/2023.
//

import SwiftUI

struct CarRowInfoView: View {
    @Binding var carModel: Car
    let onTapGesture: () -> Void

    @Environment(\.dismiss) var dismiss

    var body: some View {
        Button {
            onTapGesture()
            dismiss()
        } label: {
            HStack {
                if let imageBase64 = carModel.imageBase64,
                    let imageData = Data(base64Encoded: imageBase64,
                                        options: .ignoreUnknownCharacters),
                   let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100)
                        .clipShape(Circle())
                }
                VStack(alignment: .leading) {
                    Text(carModel.name)
                        .font(.largeTitle)
                        .bold()
                    Text("\(carModel.brand)" + " " + "\(carModel.model)")
                }

                Spacer()
                FuelTypeIcon(fuelType: carModel.fuelType)
                    .frame(width: 50)
                    .padding()
            }
        }
    }
}

struct CarRowInfoView_Previews: PreviewProvider {
    static var previews: some View {
        CarRowInfoView(carModel: .constant(Car.mock)) {}
    }
}
