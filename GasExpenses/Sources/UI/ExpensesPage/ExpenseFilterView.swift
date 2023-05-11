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
                CollapsableCardWithTitleView(title: LocalizedStringKey("amount.from")) {
                    TextField("", text: $viewModel.filters.amountFrom)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                }

                CollapsableCardWithTitleView(title: LocalizedStringKey("amount.to")) {
                    TextField("", text: $viewModel.filters.amountTo)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                }

                CollapsableCardWithTitleView(title: LocalizedStringKey("date.from")) {
                    DatePicker("",
                               selection: $viewModel.filters.dateFrom.toUnwrapped(defaultValue: .now),
                               displayedComponents: .date)
                        .datePickerStyle(.graphical)
                        .tint(.ui.action)
                        .padding()
                }

                CollapsableCardWithTitleView(title: LocalizedStringKey("date.to")) {
                    DatePicker("",
                               selection: $viewModel.filters.dateTo.toUnwrapped(defaultValue: .now),
                               displayedComponents: .date)
                        .datePickerStyle(.graphical)
                        .tint(.ui.action)
                        .padding()
                }

                CollapsableCardWithTitleView(title: LocalizedStringKey("expense.type")) {
                    Picker(selection: .constant("fuel"), label: Text("pick")) {
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
        ExpenseFilterView(viewModel: .init(carID: 0,
                                           carDataSource: CarDataSource(carService: CarService()),
                                           refuelService: RefuelService()))
    }
}
