//
//  ExpensesOverviewView.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 11/04/2023.
//

import SwiftUI

enum ExpensesOverviewSelection {
    case expenses
    case refuels
}

struct ExpensesOverviewView: View {
    @State var isShowingFilterSheet = false
    @State var isShowingAddExpenseSheet = false
    @State var isShowingCarSelectSheet = false
    @State var selectedExpenseType: ExpensesOverviewSelection = .refuels

    @ObservedObject var viewModel: ExpensesOverviewViewModel
    @EnvironmentObject var carDataSource: CarDataSource

    var body: some View {
        NavigationView {
            ZStack {
                Color.ui.background
                    .ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack {
                        TitleAndIconHeaderView(title: $selectedExpenseType.wrappedValue == .expenses ? "expenses.title" : "refuels.title") {
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

                        Picker(selection: $selectedExpenseType, label: Text("Expense type")) {
                            Text("expenses.title")
                                .tag(ExpensesOverviewSelection.expenses)
                            Text("refuels.title")
                                .tag(ExpensesOverviewSelection.refuels)
                        }
                        .pickerStyle(.segmented)
                        .padding()

                        ExpensesFilterSection(viewModel: viewModel)

                        if selectedExpenseType == .expenses {
                            ForEach($viewModel.groupedExpenses) { monthExpenses in
                                CollapsableCardWithTitleView(title: monthExpenses.wrappedValue.date.monthAndYearString()) {
                                    ForEach(monthExpenses.wrappedValue.expenses) { expense in
                                        NavigationLink(destination: ExpenseDetailsView(expense: expense)) {
                                            ExpenseRowView(expense: expense)
                                        }
                                        .buttonStyle(.plain)
                                    }
                                }
                            }
                        } else {
                            ForEach($viewModel.groupedRefuels) { monthlyRefuels in
                                CollapsableCardWithTitleView(title: monthlyRefuels.wrappedValue.date.monthAndYearString()) {
                                    ForEach(monthlyRefuels.refuels.wrappedValue) {
                                        RefuelRowView(refuel: $0)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                    }
                }
            }
            .onChange(of: selectedExpenseType, perform: { newValue in
                switch newValue {
                case .expenses:
                    viewModel.getLastMonthExpenses()
                case .refuels:
                    viewModel.getLastMonthRefuels()
                }
            })
            .onAppear {
                Task {
                    do {
                        try await viewModel.getExpenses()
                        viewModel.groupExpenses()
                        try await viewModel.getRefuels()
                        viewModel.groupRefuels()
                        viewModel.getLastMonthRefuels()
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
        ExpensesOverviewView(viewModel: ExpensesOverviewViewModel(carID: 0,
                                                                  carDataSource: CarDataSource(carService: CarService()),
                                                                  refuelService: RefuelService()))
    }
}
