//
//  ButtonPrimary.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 07/05/2023.
//

import SwiftUI

struct ButtonPrimary<Content: View>: View {

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
        .buttonStyle(.borderedProminent)
    }
}

struct ButtonPrimary_Previews: PreviewProvider {
    static var previews: some View {
        ButtonPrimary {
            Text("sign.up")
        } action: {

        }

    }
}
