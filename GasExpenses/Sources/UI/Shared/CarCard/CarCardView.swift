//
//  CarCardView.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 08/04/2023.
//

import SwiftUI

struct CarCardView: View {
    @ObservedObject var viewModel: CarCardViewModel
    @State var shouldShowSheet = true

    let allowsCarSelection: Bool

    init(viewModel: CarCardViewModel,
         allowsCarSelection: Bool = false) {
        self.viewModel = viewModel
        self.allowsCarSelection = allowsCarSelection

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

                        if allowsCarSelection {
                            Button {
                                shouldShowSheet.toggle()
                            } label: {
                                Image(systemName: "chevron.down")
                            }
                            .tint(.ui.action)
                            .foregroundColor(.white)
                            .buttonStyle(.borderedProminent)
                        }

                        Spacer()
                    }

                    ForEach(viewModel.carInfoRows) { carInfo in
                        CarCardInfoRow(configuration: carInfo)
                    }

                    HStack {
                        Spacer()
                        NavigationLink {
                            CarDetailsView()
                        } label: {
                            Label("see.more", systemImage: "chevron.right")
                        }

                        .tint(.ui.action)
                        .foregroundColor(.white)
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                }
            }
            .sheet(isPresented: $shouldShowSheet) {
                ForEach(viewModel.getCars()) { car in
                    CarRowInfoView(carModel: car)
                }
            }
    }
}

struct CarCardView_Previews: PreviewProvider {
    static var previews: some View {
        CarCardView(viewModel: .init(carService: CarDataSource()))
    }
}
