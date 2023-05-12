//
//  RefuelRowView.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 11/05/2023.
//

import SwiftUI

struct RefuelRowView: View {
    let refuel: Refuel

    var body: some View {
        HStack {
            ExpenseTypeIcon(expenseType: .fuel)
            VStack(alignment: .leading) {
                Text(refuel.title)
                    .bold()
                Text(refuel.date.dateFromJSON()?.dayAndMonthString() ?? "")
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text((refuel.fuelAmount * refuel.costPerUnit).currencyString() ?? "")
                    .foregroundColor(.ui.warning)
                Text(refuel.costPerUnit.currencyString() ?? "")
            }
            Image(systemName: "chevron.right")
                .font(.title)
                .foregroundColor(.ui.action)
                .padding()
        }
    }
}

struct RefuelRowView_Previews: PreviewProvider {
    static var previews: some View {
        RefuelRowView(refuel: .mock)
    }
}
