//
//  PlaceholderTextView.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 16/05/2023.
//

import SwiftUI

struct PlaceholderTextView: View {
    let text: LocalizedStringKey
    var body: some View {
        HStack {
            Spacer()
            Text(text)
                .multilineTextAlignment(.center)
                .bold()
                .opacity(0.6)
            Spacer()
        }
    }
}

struct PlaceholderTextView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceholderTextView(text: "car.card.refuel.empty")
            .previewLayout(.sizeThatFits)
    }
}
