//
//  ButtonDestructive.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 12/05/2023.
//

import SwiftUI

struct ButtonDestructive<Content: View>: View {
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
        .tint(.ui.warning)
        .buttonStyle(.borderedProminent)
    }
}

struct ButtonDestructive_Previews: PreviewProvider {
    static var previews: some View {
        ButtonDestructive {
            Text("delete")
        } action: {}
    }
}
