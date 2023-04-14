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
        VStack {
            TextField("Amount", text: $amount)
                .textFieldStyle(.roundedBorder)
                .padding()
            TextField("Amount", text: $amount)
                .textFieldStyle(.roundedBorder)
                .padding()
            DatePicker("Date", selection: $date, displayedComponents: [.date])
                .datePickerStyle(.graphical)
            Picker("Fuel type", selection: $expenseType) {
                ForEach(ExpenseType.allCases) {
                    Text($0.rawValue.uppercased()).tag($0.rawValue)
                }
            }
            .datePickerStyle(.compact)
        }
        .background(Color.ui.background)
        .ignoresSafeArea()
    }
}

struct AddExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExpenseView()
    }
}
