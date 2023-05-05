//
//  AddExpenseView.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 14/04/2023.
//

import SwiftUI

struct AddExpenseView: View {

    @ObservedObject var viewModel: AddExpenseViewModel
    @Environment(\.dismiss) var dismiss

    @State var showCardSelectionSheet = false

    var body: some View {
        ZStack {
            Color.ui.background
                .ignoresSafeArea()
            VStack {
                TitleAndTextField(title: "title",
                                  textFieldValue: $viewModel.title)
                TitleAndTextField(title: "amount",
                                  textFieldValue: $viewModel.amount)

                HStack {
                    Text("expense.type")
                    Spacer()
                    Picker("fuel.type", selection: $viewModel.expenseType) {
                        ForEach(ExpenseType.allCases.sorted { lhs, rhs in
                            return lhs.rawValue < rhs.rawValue
                        }) {
                            Text($0.rawValue.capitalized).tag($0.rawValue)
                        }
                    }
                    .tint(Color.ui.action)
                }

                HStack {
                    Text("car")
                    Spacer()
                    Button(action: {
                        showCardSelectionSheet = true
                    }, label: {
                        Text(viewModel.car?.name ?? "select.car")
                    })
                    .padding()
                    .tint(Color.ui.action)
                }

                DatePicker("date", selection: $viewModel.date, displayedComponents: [.date])
                    .tint(Color.ui.action)
                    .datePickerStyle(.graphical)
                Spacer()
                Button {
                    viewModel.addExpense()
                    dismiss()
                } label: {
                    Spacer()
                    Text("add")
                    Spacer()
                }
                .tint(Color.ui.action)
                .buttonStyle(.borderedProminent)

            }
            .sheet(isPresented: $showCardSelectionSheet,
                   content: {
                ForEach(viewModel.cars) { car in
                    CarRowInfoView(carModel: .constant(car)) {
                        viewModel.car = car
                    }
                }})
            .padding()
            .onAppear {
                viewModel.getCars()
            }
        }
    }
}

struct AddExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExpenseView(viewModel: .init(carDataStore: CarDataSource(carService: CarService()),
                                        expenseService: ExpenseService()))
    }
}
