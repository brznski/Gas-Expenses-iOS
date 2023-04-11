//
//  ExpensesFilterSection.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 11/04/2023.
//

import SwiftUI

struct ExpensesFilterSection: View {
    @Binding var buttonState: Bool

    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                Button {
                    buttonState.toggle()
                } label: {
                    Label("Filter", systemImage: "line.3.horizontal.decrease.circle.fill")
                }
                .buttonStyle(.borderedProminent)
                .tint(.ui.action)

                HStack {
                    Text("Above 13")
                    Button {

                    } label: {
                        Image(systemName: "xmark.circle.fill")
                    }
                    .tint(Color.ui.action)
                }
                .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .padding(8)
                            .foregroundColor(.ui.contentOnBackground)
                    )

                Spacer()
            }
            .padding()
        }
    }
}

struct ExpensesFilterSection_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesFilterSection(buttonState: .constant(true))
    }
}
