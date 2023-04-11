//
//  ExpenseRowView.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 11/04/2023.
//

import SwiftUI

struct ExpenseRowView: View {
    var body: some View {
        HStack {
            Circle()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50)
                .padding()
            VStack(alignment: .leading) {
                Text("Paliwo")
                    .bold()
                Text("25th June 2023")
            }
            Spacer()
            Text("-300 zł")
                .foregroundColor(.ui.warning)
            Image(systemName: "chevron.right")
                .font(.title)
                .foregroundColor(.ui.action)
                .padding()
        }
    }
}

struct ExpenseRowView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseRowView()
    }
}
