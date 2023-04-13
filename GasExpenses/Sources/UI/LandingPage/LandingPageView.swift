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
                        TitleAndIconHeaderView(title: "My overview") {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                        }
                        CarCardView(viewModel: .init(carService: CarDataSource()), allowsCarSelection: true)
                        LadingPageActionCardGroup()
                    }
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
