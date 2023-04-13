//
//  ExpenseFilterView.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 12/04/2023.
//

import SwiftUI

struct ExpenseFilterView: View {

    @ObservedObject var viewModel: ExpensesOverviewViewModel

    var body: some View {
        ScrollView {
            VStack {
                CollapsableCardWithTitleView(title: "Amount from") {
                    TextField("", text: $viewModel.filters.amountFrom)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                }

                CollapsableCardWithTitleView(title: "Amount to") {
                    TextField("", text: $viewModel.filters.amountTo)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                }

                CollapsableCardWithTitleView(title: "Date from") {
                    DatePicker("",
                               selection: $viewModel.filters.dateFrom.toUnwrapped(defaultValue: .now),
                               displayedComponents: .date)
                        .datePickerStyle(.graphical)
                        .tint(.ui.action)
                        .padding()
                }

                CollapsableCardWithTitleView(title: "Date to") {
                    DatePicker("",
                               selection: $viewModel.filters.dateTo.toUnwrapped(defaultValue: .now),
                               displayedComponents: .date)
                        .datePickerStyle(.graphical)
                        .tint(.ui.action)
                        .padding()
                }

                CollapsableCardWithTitleView(title: "Expense type") {
                    Picker(selection: .constant("Fuel"), label: Text("Pick")) {
                        ForEach(ExpenseType.allCases) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.menu)
                }
            }
        }.background(Color.ui.background)
    }
}

struct ExpenseFilterView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseFilterView(viewModel: .init())
    }
}
