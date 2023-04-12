//
//  ExpensesOverviewView.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 11/04/2023.
//

import SwiftUI

struct ExpensesOverviewView: View {

    @State var isShowingFilterSheet = false

    private let viewModel = ExpensesOverviewViewModel()

    var body: some View {
        ZStack {
            Color.ui.background
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack {
                    TitleAndIconHeaderView<EmptyView>(title: "Expenses title")
                    CardWithTitleView(title: "Recent expenses",
                                      alignment: .leading) {
                        Text("350,50 zł")
                            .font(.largeTitle)
                            .bold()
                            .padding()
                    }
                    ExpensesFilterSection(buttonState: $isShowingFilterSheet)
                    ForEach(viewModel.groupedExpenses.sorted { $0.date > $1.date }) { expenses in
                        CardWithTitleView(title: expenses.date.monthAndYearString()) {
                            ForEach(expenses.expenses) {
                                ExpenseRowView(expense: $0)
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
        ExpensesOverviewView()
    }
}
