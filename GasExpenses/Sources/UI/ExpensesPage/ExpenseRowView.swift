//
//  ExpenseRowView.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 11/04/2023.
//

import SwiftUI

struct ExpenseRowView: View {
    let expense: Expense

    var body: some View {
        HStack {
            ExpenseTypeIcon(expenseType: expense.expenseType)
            VStack(alignment: .leading) {
                Text(expense.title)
                    .bold()
                Text(expense.date.dateFromJSON()?.dayAndMonthString() ?? "")
            }
            Spacer()
            Text(expense.amount.currencyString() ?? "")
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
        ExpenseRowView(expense: .mock)
    }
}
