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
        CardWithTitleView(title: "Current car") {
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
                    .buttonStyle(.bordered)


                    Spacer()
                }
                CardCardInfoRow(labelText: "300", labelImage: "gauge", helpText: "-30", isPositive: true)
                CardCardInfoRow(labelText: "300", labelImage: "gauge", helpText: "-30", isPositive: false)
                HStack {
                    Spacer()
                    Button {
                        
                    } label: {
                        Label("See more", systemImage: "chevron.right")
                    }
                    .buttonStyle(.bordered)
                }
                .padding()
            }
        }
    }
}

struct CarCardView_Previews: PreviewProvider {
    static var previews: some View {
        CarCardView(viewModel: .init(model: Car(name: "My car",
                                                brand: "Subaru",
                                                model: "Impreza WRX",
                                                refuels: [])))
    }
}
