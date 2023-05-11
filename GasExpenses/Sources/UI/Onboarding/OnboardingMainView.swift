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
            OnboardingView(systemName: "person.3.fill",
                           contentText: "onboarding.account.text",
                           primaryButtonConfig: ButtonConfig(title: "add.car") {},
                           secondaryButtonConfig: ButtonConfig(title: "maybe.later") {})
            .tag(0)
            OnboardingView(systemName: "car.2.fill",
                           contentText: "onboarding.car.text",
                           primaryButtonConfig: ButtonConfig(title: "add.car") {},
                           secondaryButtonConfig: ButtonConfig(title: "maybe.later") {})
            .tag(1)
            OnboardingView(systemName: "camera.fill",
                           contentText: "onboarding.camera.text",
                           primaryButtonConfig: ButtonConfig(title: "allow.camera.permission") {},
                           secondaryButtonConfig: ButtonConfig(title: "maybe.later") {})
            .tag(2)
            OnboardingView(systemName: "mappin.and.ellipse",
                           contentText: "onboarding.localization.text",
                           primaryButtonConfig: ButtonConfig(title: "allow.localization.permission") {},
                           secondaryButtonConfig: ButtonConfig(title: "maybe.later") {})
            .tag(3)
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
