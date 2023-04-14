//
//  AddExpenseView.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 14/04/2023.
//

import SwiftUI

struct AddExpenseView: View {
    @State var amount: String = "0"
    @State var date: Date = .now
    @State var expenseType: String = ""

    var body: some View {
        ZStack {
            Color.ui.background
                .ignoresSafeArea()
            VStack {
                TitleAndTextField(title: "amount",
                                  textFieldValue: $amount)
                TitleAndTextField(title: "title",
                                  textFieldValue: $amount)
                HStack {
                    Text("expense.type")
                    Spacer()
                    Picker("Fuel type", selection: $expenseType) {
                        ForEach(ExpenseType.allCases.sorted(by: { lhs, rhs in
                            return lhs.rawValue < rhs.rawValue
                        })) {
                            Text($0.rawValue.capitalized).tag($0.rawValue)
                        }
                    }
                    .tint(Color.ui.action)
                }
                DatePicker("Date", selection: $date, displayedComponents: [.date])
                    .tint(Color.ui.action)
                    .datePickerStyle(.graphical)
                Spacer()
                Button {

                } label: {
                    Spacer()
                    Text("add")
                    Spacer()
                }
                .tint(Color.ui.action)
                .buttonStyle(.borderedProminent)

            }
            .padding()

        }
    }
}

struct AddExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExpenseView()
    }
}
