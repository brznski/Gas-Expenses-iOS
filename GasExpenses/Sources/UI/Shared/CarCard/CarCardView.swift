//
//  CarCardView.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 08/04/2023.
//

import SwiftUI

enum CarCardContext {
    case landingPage
    case carOverview
    case carDetails
}

struct CarCardView: View {
    @ObservedObject var viewModel: CarCardViewModel
    @State var shouldShowSheet: Bool = false
    @EnvironmentObject var carDataSource: CarDataSource

    let cardContext: CarCardContext
    var onChevronDownTap: (() -> Void)? = {}

    var body: some View {
        CardWithTitleView(title: viewModel.getHeader(context: cardContext)) {
            VStack {
                if let carModel = viewModel.model,
                   let imageBase64 = carModel.imageBase64,
                   let imageData = Data(base64Encoded: imageBase64),
                   let uiImage = UIImage(data: imageData) {
                    ImageWithGradientView(imageName: uiImage)
                }
                HStack {
                    HStack {
                        Text(viewModel.getTitle(context: cardContext))
                            .font(.title2).bold()
                            .padding()

                        if cardContext == .carOverview {
                            Button {
                                viewModel.model?.isFavourite.toggle()
                                viewModel.setFavouriteCar()
                                carDataSource.setFavouriteCar(carID: viewModel.model?.id ?? -1)
                            } label: {
                                Image(systemName: viewModel.model!.isFavourite ? "heart.fill" : "heart")
                                    .foregroundColor(.ui.action)
                            }
                        }
                    }

                    if cardContext == .landingPage && carDataSource.cars.count > 1 {
                        Button {
                            onChevronDownTap?()
                        } label: {
                            Image(systemName: "chevron.down")
                        }
                        .tint(.ui.action)
                        .foregroundColor(.white)
                        .buttonStyle(.borderedProminent)
                    }

                    Spacer()
                }

                ForEach($viewModel.carInfoRows) { carInfo in
                    CarCardInfoRow(configuration: carInfo.wrappedValue)
                }

                if $viewModel.carInfoRows.isEmpty {
                    HStack {
                        Spacer()
                        Text("car.card.refuel.empty")
                            .padding([.horizontal, .bottom])
                            .multilineTextAlignment(.center)
                            .opacity(0.7)
                        Spacer()
                    }
                }

                if cardContext != .carDetails {
                    HStack {
                        Spacer()
                        NavigationLink {
                            CarDetailsView(model: viewModel.model!,
                                           viewModel: CarDetailsViewModel(carService: CarService()))
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
        }
    }
}

struct CarCardView_Previews: PreviewProvider {
    static var previews: some View {
        CarCardView(viewModel: .init(car: .mock,
                                     carService: CarService()),
                    cardContext: .landingPage) {}
            .environmentObject(CarDataSource(carService: CarService()))
    }
}
