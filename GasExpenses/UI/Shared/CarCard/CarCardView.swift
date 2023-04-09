//
//  CarCardView.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 08/04/2023.
//

import SwiftUI

struct CarCardView: View {
    let viewModel: CarCardViewModel
    
    var body: some View {
        CardWithTitleView(title: "landingpage.car.card.title") {
            VStack {
                ImageWithGradientView(imageName: "car_image_test")
                HStack {
                    Text(viewModel.getCarName())
                        .font(.title2).bold()
                        .padding()
                    Button {
                        
                    } label: {
                        Image(systemName: "chevron.down")
                    }
                    .tint(.ui.actionBackground)
                    .foregroundColor(.ui.action)
                    .buttonStyle(.borderedProminent)

                    Spacer()
                }
                
                ForEach(viewModel.carInfoRows, id: \.self) { carInfo in
                    CarCardInfoRow(configuration: carInfo)
                }

                HStack {
                    Spacer()
                    Button {
                        
                    } label: {
                        Label("see.more", systemImage: "chevron.right")
                    }
                    .tint(.ui.actionBackground)
                    .foregroundColor(.ui.action)
                    .buttonStyle(.borderedProminent)
                }
                .padding()
            }
        }
    }
}

struct CarCardView_Previews: PreviewProvider {
    static var previews: some View {
        CarCardView(viewModel: .init(model: Car(name: "Subaru",
                                                brand: "Subaru",
                                                model: "Impreza WRX",
                                                refuels: [])))
    }
}