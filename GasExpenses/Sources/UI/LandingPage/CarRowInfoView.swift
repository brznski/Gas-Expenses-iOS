//
//  CarRowInfoView.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 13/04/2023.
//

import SwiftUI

struct CarRowInfoView: View {
    let carModel: Car
    let onTapGesture: () -> Void

    @Environment(\.dismiss) var dismiss

    var body: some View {
        Button {
            onTapGesture()
            dismiss()
        } label: {
            HStack {
                Image("car_image_test")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100)
                    .clipShape(Circle())
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
        CarRowInfoView(carModel: .init(id: 1, name: "My Subaru",
                                       brand: "Subaru",
                                       model: "Impreza", refuels: [],
                                       fuelType: .pb95,
                                       isFavourite: true), onTapGesture: {})
    }
}
