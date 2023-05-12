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
                ScrollView {
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
                        MapPreviewCard(region: .init(center: .init(latitude: latitude, longitude: longitude),
                                                     latitudinalMeters: 700,
                                                     longitudinalMeters: 700)) { location in
                            viewModel.longitude = location.longitude
                            viewModel.latitude = location.latitude
                        }
                    } else {
                        MapPreviewCard {
                            viewModel.longitude = $0.longitude
                            viewModel.latitude = $0.latitude
                        }
                    }
                    
                    CardWithTitleView(title: LocalizedStringKey("image")) {
                        VStack {
                            if let documentPhotoData = $viewModel.documentBase64.wrappedValue {
                                Image(uiImage: .init(data: documentPhotoData)!)
                                    .resizable()
                                    .padding()
                                    .scaledToFit()
                                    .cornerRadius(8)

                            }
                            VStack(spacing: 2) {
                                NavigationLink(destination: CameraView(onPhotoSelected: { data in
                                    viewModel.documentBase64 = data
                                })) {
                                    Spacer()
                                    Label($viewModel.documentBase64.wrappedValue == nil ? "add.document.photo" : "edit.document.photo",
                                          systemImage: "doc")
                                    Spacer()
                                }
                                .padding(.horizontal)
                                .buttonStyle(.borderedProminent)

                                if $viewModel.documentBase64.wrappedValue != nil {
                                    ButtonDestructive {
                                        Label("delete",
                                              systemImage: "trash.fill")
                                    } action: {
                                        viewModel.documentBase64 = nil
                                    }
                                    .padding()
                                }
                            }
                        }
                    }

                    ButtonPrimary {
                        Text(viewModel.context == .add ? "add" : "edit")
                    } action: {
                        viewModel.addExpense()
                        dismiss()
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
                                        expenseService: ExpenseService()))
    }
}
