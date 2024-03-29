//
//  TitleAndSecureField.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 07/05/2023.
//

import SwiftUI

struct TitleAndSecureField: View {
    let title: LocalizedStringKey
    let inputAutocapitalization: TextInputAutocapitalization = .never
    @Binding var textFieldValue: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
            SecureField("", text: $textFieldValue)
                .textInputAutocapitalization(inputAutocapitalization)
                .textFieldStyle(.roundedBorder)
        }
    }
}

struct TitleAndSecureField_Previews: PreviewProvider {
    static var previews: some View {
        TitleAndSecureField(title: "password",
                            textFieldValue: .constant("12345678"))
    }
}
