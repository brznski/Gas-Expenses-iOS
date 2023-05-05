//
//  ExpenseRowView.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 11/04/2023.
//

import SwiftUI

struct Expense: Identifiable, Codable {
    let id: Int
    let amount: Double
    let title: String
    let date: String
    let expenseType: ExpenseType
}

enum ExpenseType: String, Identifiable, CaseIterable, Codable {
    var id: String { return self.rawValue }
    case fuel
    case wash
    case maintenance
    case insurance
    case parts
}

struct ExpenseRowView: View {
    let expense: Expense

    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50)
                    .padding()
                switch expense.expenseType {
                case .fuel:
                    Image(systemName: "fuelpump.fill")
                        .foregroundColor(.white)
                case .insurance:
                    Image(systemName: "umbrella.fill")
                        .foregroundColor(.white)
                case .maintenance:
                    Image(systemName: "wrench.and.screwdriver.fill")
                        .foregroundColor(.white)
                case .parts:
                    Image(systemName: "gearshape.fill")
                        .foregroundColor(.white)
                case .wash:
                    Image(systemName: "sparkles")
                        .foregroundColor(.white)
                }
            }
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
        ExpenseRowView(expense: .init(id: 3, amount: 350.3, title: "Paliwo", date: "", expenseType: .fuel))
    }
}
