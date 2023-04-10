//
//  ActionCard.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 08/04/2023.
//

import SwiftUI

struct ActionCard: View {
    let title: LocalizedStringKey
    let imageSystemName: String

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(Color.ui.actionBackground)
                VStack {
                    Image(systemName: imageSystemName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: geometry.size.height * 0.3)
                        .foregroundColor(.ui.action)
                        .padding()
                    Spacer()
                    Text(title)
                        .foregroundColor(.ui.action)
                        .padding()
                        .multilineTextAlignment(.center)
                }
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

struct ActionCard_Previews: PreviewProvider {
    static var previews: some View {
        ActionCard(title: "landingPage.actionCard.addFuel",
                   imageSystemName: "fuelpump.fill")
    }
}
