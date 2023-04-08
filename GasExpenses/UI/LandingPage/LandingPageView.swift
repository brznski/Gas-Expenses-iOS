//
//  LandingPageView.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 08/04/2023.
//

import SwiftUI

struct LandingPageView: View {
    var body: some View {
        ZStack {
            Color.ui.background
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    TitleAndIconHeaderView(title: "My overview") {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                    }
                    CarCardView(viewModel: .init(model: Car(name: "My car", brand: "", model: "", refuels: [])))
                    }
                }
            }
        }
    }

struct LandingPageView_Previews: PreviewProvider {
    static var previews: some View {
        LandingPageView()
    }
}
