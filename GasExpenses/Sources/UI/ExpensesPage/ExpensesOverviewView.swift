//
//  ExpensesOverviewView.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 11/04/2023.
//

import SwiftUI

struct ExpensesOverviewView: View {

    @State var isShowingFilterSheet = false

    @ObservedObject var viewModel: ExpensesOverviewViewModel

    var body: some View {
        NavigationView {
            ZStack {
                Color.ui.background
                    .ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack {
                        TitleAndIconHeaderView<EmptyView>(title: "Expenses title")
                        CardWithTitleView(title: "Recent expenses",
                                          alignment: .leading) {
                            Text(viewModel.getLastMonthExpenses().currencyString() ?? "")
                                .font(.largeTitle)
                                .bold()
                                .padding()
                        }
                        ExpensesFilterSection(viewModel: viewModel)
                        ForEach(viewModel.groupedExpenses.sorted { $0.date > $1.date }) { expenses in
                            CollapsableCardWithTitleView(title: expenses.date.monthAndYearString()) {
                                ForEach(expenses.expenses) {
                                    ExpenseRowView(expense: $0)
                                }
                            }
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $isShowingFilterSheet) {
            Text("Test")
        }
    }
}

struct ExpensesOverviewView_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesOverviewView(viewModel: ExpensesOverviewViewModel())
    }
}
