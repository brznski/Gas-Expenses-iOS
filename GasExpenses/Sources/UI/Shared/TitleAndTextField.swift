//
//  TitleAndTextField.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 14/04/2023.
//

import SwiftUI

struct TitleAndTextField: View {
    let title: LocalizedStringKey
    let inputAutocapitalization: TextInputAutocapitalization = .sentences
    @Binding var textFieldValue: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
            TextField("", text: $textFieldValue)
                .textInputAutocapitalization(.never)
                .textFieldStyle(.roundedBorder)
        }
    }
}

struct TitleAndTextField_Previews: PreviewProvider {
    static var previews: some View {
        TitleAndTextField(title: "amount", textFieldValue: .constant("3"))
    }
}
