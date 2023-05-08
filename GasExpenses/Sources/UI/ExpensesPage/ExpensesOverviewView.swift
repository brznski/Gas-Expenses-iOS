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
    @State var isShowingCarSelectSheet = false

    @ObservedObject var viewModel: ExpensesOverviewViewModel
    @EnvironmentObject var carDataSource: CarDataSource

    var body: some View {
        NavigationView {
            ZStack {
                Color.ui.background
                    .ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack {
                        TitleAndIconHeaderView(title: "expenses.title") {
                            Button {
                                isShowingAddExpenseSheet.toggle()
                            } label: {
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .tint(.ui.action)
                                    .frame(width: 30, height: 30)
                            }
                        }

                            CardWithTitleView(title: LocalizedStringKey("expenses.recent"),
                                              alignment: .leading) {
                                Text($viewModel.lastMonthExpenses.wrappedValue.currencyString() ?? "")
                                    .font(.largeTitle)
                                    .bold()
                                    .padding()
                            }

                        ExpensesFilterSection(viewModel: viewModel)

                        ForEach($viewModel.groupedExpenses) { monthExpenses in
                            CollapsableCardWithTitleView(title: monthExpenses.wrappedValue.date.monthAndYearString()) {
                                ForEach(monthExpenses.wrappedValue.expenses) { expense in
                                    NavigationLink(destination: ExpenseDetailsView(expense: expense)) {
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
                        viewModel.getLastMonthExpenses()
                    } catch {

                    }
                }
            }
        }
        .sheet(isPresented: $isShowingAddExpenseSheet) {
            Task {
                do {
                    try await viewModel.getExpenses()
                    viewModel.groupExpenses()
                    viewModel.getLastMonthExpenses()
                }
            }
        } content: {
            AddExpenseView(viewModel: AddExpenseViewModel(carDataStore: CarDataSource(carService: CarService()),
                                                          expenseService: ExpenseService(),
                                                          carID: viewModel.carID))
        }
        }
}

struct ExpensesOverviewView_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesOverviewView(viewModel: ExpensesOverviewViewModel(carID: 0, carDataSource: CarDataSource(carService: CarService())))
    }
}
