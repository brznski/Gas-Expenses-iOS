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
                CardWithTitleView(title: "main") {
                    VStack {
                        TitleAndTextField(title: "title",
                                          textFieldValue: $viewModel.filters.title)
                            .padding()
                        HStack {
                            Text("expense.type")
                            Spacer()
                            Picker(selection: $viewModel.filters.expenseType,
                                   label: Text("pick")) {
                                ForEach(ExpenseType.allCases.filter { $0 != .fuel }) {
                                    Text($0.rawValue.capitalized)
                                }
                            }
                            .pickerStyle(.menu)
                        }
                        .padding()
                    }
                }
                CardWithTitleView(title: "amount") {
                    VStack {
                        TitleAndTextField(title: "amount.from",
                                          textFieldValue: $viewModel.filters.amountFrom)
                        TitleAndTextField(title: "amount.to",
                                          textFieldValue: $viewModel.filters.amountTo)
                    }
                    .padding()
                }

                CardWithTitleView(title: "date") {
                    VStack {
                        DatePicker("date.from",
                                   selection: $viewModel.filters.dateFrom.toUnwrapped(defaultValue: .now),
                                   displayedComponents: .date)
                        .datePickerStyle(.compact)
                        .tint(.ui.action)
                        .padding()
                        DatePicker("date.to",
                                   selection: $viewModel.filters.dateTo.toUnwrapped(defaultValue: .now),
                                   displayedComponents: .date)
                            .datePickerStyle(.compact)
                            .tint(.ui.action)
                            .padding()
                    }
                }
            }
        }.background(Color.ui.background)
    }
}

struct ExpenseFilterView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseFilterView(viewModel: .init(carID: 0,
                                           carDataSource: CarDataSource(carService: ServiceLocator.shared.getCarService()),
                                           refuelService: ServiceLocator.shared.getRefuelService()))
    }
}
