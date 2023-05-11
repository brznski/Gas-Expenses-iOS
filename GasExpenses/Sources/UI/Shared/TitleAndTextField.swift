//
//  TitleAndTextField.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 14/04/2023.
//

import SwiftUI

struct TitleAndTextField: View {
    let title: LocalizedStringKey
    @Binding var textFieldValue: String
    let inputAutocapitalization: TextInputAutocapitalization = .sentences
    let axis: Axis = .vertical
    var keyboardType: UIKeyboardType = .asciiCapable

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
            TextField("", text: $textFieldValue, axis: axis)
                .keyboardType(keyboardType)
                .textInputAutocapitalization(inputAutocapitalization)
                .textFieldStyle(.roundedBorder)
        }
    }
}

struct TitleAndTextField_Previews: PreviewProvider {
    static var previews: some View {
        TitleAndTextField(title: "amount", textFieldValue: .constant("3"))
    }
}
