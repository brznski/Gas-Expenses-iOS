//
//  LandingPageView.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 08/04/2023.
//

import SwiftUI

struct LandingPageView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.ui.background
                    .ignoresSafeArea()
                ScrollView(showsIndicators: false) {
                    VStack() {
                        TitleAndIconHeaderView(title: "My overview") {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                        }
                        CarCardView(viewModel: .init(model: Car(name: "My Subaru",
                                                                brand: "",
                                                                model: "",
                                                                refuels: [
                                                                    (.now, 250000, 300),
                                                                    (.now, 250150.3, 200),
                                                                    (.now, 251300.3, 60)
                                                                ])))
                        LadingPageActionCardGroup()
                    }
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
