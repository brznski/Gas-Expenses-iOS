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

    @State var showCardSelectionSheet = false

    var body: some View {
        NavigationView {
            ScrollView {
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

                        DatePicker("date", selection: $viewModel.date,
                                   displayedComponents: [.date])
                        .tint(Color.ui.action)
                        .datePickerStyle(.graphical)
                        Spacer()

                        if let region = $locationManager.region,
                           region.wrappedValue != nil {
                            Map(coordinateRegion: region.toUnwrapped(defaultValue: .init(.world)),
                                showsUserLocation: true)
                            .frame(height: 300)
                            .cornerRadius(8)
                            .padding()
                        }

                        LocationButton(.shareMyCurrentLocation) {
                            locationManager.requestLocation()
                        }
                        .cornerRadius(8)
                        .frame(height: 44)
                        .foregroundColor(.white)
                        .padding()

                        NavigationLink(destination: LocationSelectionView(onSelectedLocalization: { coordinate in
                            locationManager.location = coordinate
                            viewModel.latitude = coordinate.latitude
                            viewModel.longitude = coordinate.longitude
                        })) {
                            Text("open.map")
                        }

                        ButtonPrimary {
                            Text("add")
                        } action: {
                            viewModel.addExpense()
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
        AddExpenseView(viewModel: .init(carDataStore: CarDataSource(carService: CarService()),
                                        expenseService: ExpenseService(),
                                        carID: 0))
    }
}
