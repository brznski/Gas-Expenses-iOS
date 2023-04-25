//
//  ExpensesOverviewView.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 11/04/2023.
//

import SwiftUI

struct ExpensesOverviewView: View {

    @State var isShowingFilterSheet = false
    @State var isShowingAddExpenseSheet = false

    @ObservedObject var viewModel: ExpensesOverviewViewModel

    var body: some View {
        NavigationView {
            ZStack {
                Color.ui.background
                    .ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack {
                        TitleAndIconHeaderView(title: "Expenses title") {
                            Button {
                                isShowingAddExpenseSheet.toggle()
                            } label: {
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                            }

                        }
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
                                ForEach(expenses.expenses) { expense in
                                    NavigationLink(destination: EmptyView()) {
                                        ExpenseRowView(expense: expense)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .onAppear {
                Task {
                    do {
                        try await viewModel.getExpenses()
                        viewModel.groupExpenses()
                    } catch {
                        
                    }
                }
            }
        }
        .sheet(isPresented: $isShowingAddExpenseSheet) {
            AddExpenseView()
        }
    }
}

struct ExpensesOverviewView_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesOverviewView(viewModel: ExpensesOverviewViewModel())
    }
}
