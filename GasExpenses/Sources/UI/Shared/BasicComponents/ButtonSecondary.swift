//
//  ButtonSecondary.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 07/05/2023.
//

import SwiftUI

struct ButtonSecondary<Content: View>: View {

    let content: () -> Content
    let action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            Spacer()
            content()
            Spacer()
        }
        .tint(.ui.action)
        .buttonStyle(.bordered)
    }
}

struct ButtonSecondary_Previews: PreviewProvider {
    static var previews: some View {
        ButtonSecondary {
            Text("sign.up")
        } action: {

        }
        .previewLayout(.sizeThatFits)
    }
}
