//
//  LandingPageView.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 08/04/2023.
//

import SwiftUI

struct LandingPageView: View {
    @ObservedObject var viewModel: LandingPageViewModel

    var body: some View {
        NavigationView {
            ZStack {
                Color.ui.background
                    .ignoresSafeArea()
                ScrollView(showsIndicators: false) {
                    VStack {
                        TitleAndIconHeaderView(title: "my.overview") {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                        }
                        if let model = viewModel.cars.first(where: { $0.isFavourite}) {
                            CarCardView(viewModel: .init(car: model), cardContext: .landingPage, car: model)
                        }
                        LadingPageActionCardGroup()
                    }
                }
            }
            .onAppear {
                Task {
                    await viewModel.getCars()
                }
            }
        }
    }
}

struct LandingPageView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = LandingPageViewModel()
        LandingPageView(viewModel: viewModel)
    }
}
