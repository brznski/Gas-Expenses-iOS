//
//  OnboardingMainView.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 10/05/2023.
//

import SwiftUI
import CoreLocation
import AVFoundation

struct OnboardingMainView: View {
    @AppStorage("onboardingWasShown") private var showedOnboarding = true
    @State private var currentTab = 0
    @State private var shouldShowAddCarSheet = false

    var body: some View {
        TabView(selection: $currentTab) {
            OnboardingView(systemName: "car.2.fill",
                           contentText: "onboarding.car.text",
                           primaryButtonConfig: ButtonConfig(title: "add.car") { shouldShowAddCarSheet = true })
            .tag(0)
            OnboardingView(systemName: "camera.fill",
                           contentText: "onboarding.camera.text",
                           primaryButtonConfig: ButtonConfig(title: "allow.camera.permission") {
                AVCaptureDevice.requestAccess(for: .video) { wasAcessGranted in
                    if wasAcessGranted {
                        currentTab += 1
                    }
                }
            })
            .tag(1)
            OnboardingView(systemName: "mappin.and.ellipse",
                           contentText: "onboarding.localization.text",
                           primaryButtonConfig: ButtonConfig(title: "allow.localization.permission") {
                CLLocationManager().requestWhenInUseAuthorization()
            })
            .tag(2)
            OnboardingView(systemName: "sparkles",
                           contentText: "onboarding.localization.get.to.app",
                           primaryButtonConfig: .init(title: "take.to.app", onPress: {
                showedOnboarding = false
            }))
            .tag(3)
        }
        .background(content: {
            Color.ui.background
                .ignoresSafeArea()
        })
        .sheet(isPresented: $shouldShowAddCarSheet, content: {
            AddCarView()
        })
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

struct OnboardingMainView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingMainView()
    }
}
