//
//  CarRowInfoView.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 13/04/2023.
//

import SwiftUI

struct CarRowInfoView: View {
    let carModel: Car

    var body: some View {
        HStack {
            Image("car_image_test")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150)
                .clipShape(Circle())
            VStack(alignment: .leading) {
                Text(carModel.name)
                    .font(.largeTitle)
                    .bold()
                Text("\(carModel.brand + carModel.model)")
            }
            Spacer()
        }
    }
}

struct CarRowInfoView_Previews: PreviewProvider {
    static var previews: some View {
        CarRowInfoView(carModel: .init(name: "My Subaru",
                                       brand: "Subaru",
                                       model: "Impreza", refuels: [],
                                       fuelType: .pb95,
                                       isFavourite: true))
    }
}
