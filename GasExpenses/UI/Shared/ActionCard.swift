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
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(Color.ui.contentOnBackground)
            Label(title, systemImage: imageSystemName)
                .padding()
        }
    }
}

struct ActionCard_Previews: PreviewProvider {
    static var previews: some View {
        ActionCard(title: "", imageSystemName: "")
    }
}
