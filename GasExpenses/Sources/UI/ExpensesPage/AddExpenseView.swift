//
//  AddExpenseView.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 14/04/2023.
//

import SwiftUI
import MapKit
import CoreLocationUI

struct AddExpenseView: View {
    @ObservedObject var locationManager = LocationManager()
    @ObservedObject var viewModel: AddExpenseViewModel
    @Environment(\.dismiss) var dismiss

    @State var pin: [Location] = []
    @State var showCardSelectionSheet = false

    var body: some View {
        NavigationView {
            ZStack {
                Color.ui.background
                    .ignoresSafeArea()
                ScrollView(showsIndicators: false) {
                    CardWithTitleView(title: LocalizedStringKey("main.form")) {
                        VStack {
                            Group {
                                TitleAndTextField(title: "title",
                                                  textFieldValue: $viewModel.title)
                                TitleAndTextField(title: "comment",
                                                  textFieldValue: $viewModel.comment)
                                TitleAndTextField(title: "amount",
                                                  textFieldValue: $viewModel.amount,
                                                  keyboardType: .decimalPad)

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
                            }

                            DatePicker("date", selection: $viewModel.date,
                                       displayedComponents: [.date])
                            .tint(Color.ui.action)
                            .datePickerStyle(.compact)
                            Spacer()
                        }
                        .padding()
                    }

                    if let latitude = viewModel.latitude,
                       let longitude = viewModel.longitude {
                        MapPreviewCard(cardContext: .edit,
                                       region: .init(center: .init(latitude: latitude, longitude: longitude),
                                                     latitudinalMeters: 700,
                                                     longitudinalMeters: 700)) { location in
                            viewModel.longitude = location.longitude
                            viewModel.latitude = location.latitude
                        }
                    } else {
                        MapPreviewCard(cardContext: .edit) {
                            viewModel.longitude = $0.longitude
                            viewModel.latitude = $0.latitude
                        }
                    }

                    ImagePreviewCard(imageData: $viewModel.documentBase64,
                                     cardContext: .edit)

                    ButtonPrimary {
                        Text(viewModel.context == .add ? "add" : "edit")
                    } action: {
                        Task {
                            switch viewModel.context {
                            case .add:
                                try? await viewModel.addExpense()
                            case .edit:
                                try? await viewModel.editExpense()
                            }
                            dismiss()
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

struct AddExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExpenseView(viewModel: .init(carDataStore: CarDataSource(carService: ServiceLocator.shared.getCarService()),
                                        expenseService: ExpenseService()))
    }
}
