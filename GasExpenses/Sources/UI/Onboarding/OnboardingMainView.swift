//
//  OnboardingMainView.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 10/05/2023.
//

import SwiftUI

struct OnboardingMainView: View {
    @AppStorage("onboardingWasShown") private var showedOnboarding = true
    @State private var currentTab = 0
    var body: some View {
        TabView(selection: $currentTab) {
            Text("First View")
                .tag(0)
            Text("Second View")
                .tag(1)
            VStack {
                Text("Third View")
                Button {
                    showedOnboarding = false
                } label: {
                    Text("Get me to app")
                }

            }
                .tag(2)
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

struct OnboardingMainView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingMainView()
    }
}
