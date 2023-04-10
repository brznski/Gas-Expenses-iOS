//
//  CarCardView.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 08/04/2023.
//

import SwiftUI

struct CarCardView: View {
    @ObservedObject var viewModel: CarCardViewModel
    
    init(viewModel: CarCardViewModel) {
        self.viewModel = viewModel
        
        viewModel.getSelectedCar()
    }
    
    var body: some View {
        CardWithTitleView(title: "landingpage.car.card.title") {
            VStack {
                ImageWithGradientView(imageName: "car_image_test")
                HStack {
                    Text(viewModel.model?.name ?? "")
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
                
                ForEach(viewModel.carInfoRows) { carInfo in
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
        CarCardView(viewModel: .init(selectedCarDataStore: SelectedCarMockDataStore()))
    }
}