//
//  CarCardView.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 08/04/2023.
//

import SwiftUI

struct CarCardView: View {
    @ObservedObject var viewModel: CarCardViewModel
    @State var shouldShowSheet: Bool = false
    var car: Car

    let allowsCarSelection: Bool

    init(viewModel: CarCardViewModel,
         allowsCarSelection: Bool = false,
         car: Car) {
        self.viewModel = viewModel
        self.allowsCarSelection = allowsCarSelection
        self.car = car

        viewModel.getSelectedCar()
    }

    var body: some View {
            CardWithTitleView(title: "landingpage.car.card.title") {
                VStack {
                    ImageWithGradientView(imageName: "car_image_test")
                    HStack {
                        Text(car.name)
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
                            CarDetailsView(model: viewModel.model!)
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
                    CarRowInfoView(carModel: car) {
                        viewModel.model = car
                    }
                }
                Spacer()
            }
    }
}

struct CarCardView_Previews: PreviewProvider {
    static var previews: some View {
        // swiftlint:disable line_length
        CarCardView(viewModel: .init(car: .init(id: 0, name: "", brand: "", model: "", refuels: [], fuelType: .pb95, isFavourite: true)), car: .init(id: 0, name: "", brand: "", model: "", refuels: [], fuelType: .pb95, isFavourite: true))
    }
}
