//
//  OnboardingView.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 10/05/2023.
//

import SwiftUI

struct ButtonConfig {
    let title: LocalizedStringKey
    let onPress: () -> Void
}

struct OnboardingView: View {
    let systemName: String
    let contentText: LocalizedStringKey
    let primaryButtonConfig: ButtonConfig
    let secondaryButtonConfig: ButtonConfig

    @State private var scale = 0.6

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 80) {
                Spacer()
                Image(systemName: systemName)
                    .resizable()
                    .scaleEffect(scale)
                    .animation(.easeInOut(duration: 0.5), value: scale)
                    .scaledToFit()
                    .frame(height: geometry.size.width * 0.4)
                Text(contentText)
                    .font(.title2)
                    .multilineTextAlignment(.center)
                VStack {
                    ButtonPrimary {
                        Text(primaryButtonConfig.title)
                    } action: {
                        primaryButtonConfig.onPress()
                    }
                    ButtonSecondary {
                        Text(secondaryButtonConfig.title)
                    } action: {
                        secondaryButtonConfig.onPress()
                    }
                }
                Spacer()
            }
            .onAppear {
                scale = 1.0
            }
            .padding()
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(systemName: "lock.iphone",
                       contentText: "onboarding.account.text",
                       primaryButtonConfig: ButtonConfig(title: "add.car") {},
                       secondaryButtonConfig: ButtonConfig(title: "maybe.later") {})
    }
}
