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
                                    .frame(width: 30, height: 30)
                            }

                        }

                        if let model = $carDataSource.selectedCar {
                            CarRowInfoView(carModel: model.toUnwrapped(defaultValue: .init(id: 0, name: "", brand: "", model: "", refuels: [], fuelType: .pb95, isFavourite: false, imageBase64: ""))) {
                                isShowingCarSelectSheet = true
                            }
                        }

                        CardWithTitleView(title: LocalizedStringKey("expenses.recent"),
                                          alignment: .leading) {
                            Text(viewModel.getLastMonthExpenses().currencyString() ?? "")
                                .font(.largeTitle)
                                .bold()
                                .padding()
                        }
                        ExpensesFilterSection(viewModel: viewModel)

                        ForEach($viewModel.groupedExpenses) { monthExpenses in
                            CollapsableCardWithTitleView(title: monthExpenses.wrappedValue.date.monthAndYearString()) {
                                ForEach(monthExpenses.wrappedValue.expenses) { expense in
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
                        try await viewModel.getCars()
                        try await viewModel.getExpenses()
                        viewModel.groupExpenses()
                    } catch {

                    }
                }
            }
        }
        .sheet(isPresented: $isShowingAddExpenseSheet) {
            AddExpenseView(viewModel: AddExpenseViewModel(carDataStore: CarDataSource(carService: CarService()),
                                                          expenseService: ExpenseService()))
        }
    }
}

struct ExpensesOverviewView_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesOverviewView(viewModel: ExpensesOverviewViewModel(carID: 0, carDataSource: CarDataSource(carService: CarService())))
    }
}
