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

    let cardContext: CarCardContext
    var onChevronDownTap: (() -> Void)? = {}

    var body: some View {
            CardWithTitleView(title: "landingpage.car.card.title") {
                VStack {
                    if let model = viewModel.model {
                        ImageWithGradientView(imageName: UIImage(data: Data(base64Encoded: model.imageBase64, options: .ignoreUnknownCharacters)!)!)
                    }
                    HStack {
                        HStack {
                            Text(viewModel.model?.name ?? "")
                                .font(.title2).bold()
                                .padding()
                            Spacer()

                            if cardContext == .carOverview {
                                Button {
                                    viewModel.model?.isFavourite.toggle()
                                    viewModel.setFavouriteCar()
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

                    ForEach($viewModel.carInfoRows) { carInfo in
                        CarCardInfoRow(configuration: carInfo.wrappedValue)
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
    }
}

struct CarCardView_Previews: PreviewProvider {
    static var previews: some View {
        // swiftlint:disable line_length
        CarCardView(viewModel: .init(car: .mock,
                                     carService: CarService()),
                    cardContext: .landingPage) {}
    }
}
