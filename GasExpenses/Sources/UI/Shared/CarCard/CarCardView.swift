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
}

struct CarCardView: View {
    @ObservedObject var viewModel: CarCardViewModel
    @State var shouldShowSheet: Bool = false

    var car: Car
    let cardContext: CarCardContext
    var onChevronDownTap: (() -> Void)? = {}

    var body: some View {
            CardWithTitleView(title: "landingpage.car.card.title") {
                VStack {
                    ImageWithGradientView(imageName: UIImage(data: Data(base64Encoded: car.imageBase64, options: .ignoreUnknownCharacters)!)!)
                    HStack {
                        HStack {
                            Text(car.name)
                                .font(.title2).bold()
                                .padding()
                            Spacer()

                            if cardContext == .carOverview {
                                Button {
                                    viewModel.model?.isFavourite.toggle()
                                } label: {
                                    Image(systemName: viewModel.model!.isFavourite ? "heart.fill" : "heart")
                                        .foregroundColor(.ui.action)
                                }
                            }
                        }

                        if cardContext == .landingPage {
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
                .onAppear {
                    viewModel.getCars()
                    viewModel.getSelectedCar()
                }
            }
    }
}

struct CarCardView_Previews: PreviewProvider {
    static var previews: some View {
        // swiftlint:disable line_length
        CarCardView(viewModel: .init(car: .init(id: 0, name: "", brand: "", model: "", refuels: [], fuelType: .pb95, isFavourite: true, imageBase64: "")), car: .init(id: 0, name: "", brand: "", model: "", refuels: [], fuelType: .pb95, isFavourite: true, imageBase64: ""), cardContext: .landingPage) {}
    }
}
