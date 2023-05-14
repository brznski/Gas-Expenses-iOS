//
//  ExpenseDetailsView.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 05/05/2023.
//

import SwiftUI
import MapKit

struct MapLocation: Identifiable {
    let id = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

struct ExpenseDetailsView: View {

    @State private var showEditSheet: Bool = false
    @State private var showAlert: Bool = false
    @Environment(\.dismiss) private var dismiss

    private var mapLocations: [MapLocation] {
        [
            MapLocation(name: expense.title,
                        latitude: expense.latitude ?? 0,
                        longitude: expense.longitude ?? 0)
        ]
    }

    let expense: Expense

    @State private var region: MKCoordinateRegion?

    var body: some View {

        ScrollView(showsIndicators: false) {
            VStack {
                TitleAndIconHeaderView(title: "expenses.details") {
                    EmptyView()
                }
                CardWithTitleView(title: "\(expense.title)") {
                    VStack {
                        ExpenseDetailRowInfo(key: "amount",
                                             value: expense.amount.currencyString() ?? "")
                        ExpenseDetailRowInfo(key: "title",
                                             value: expense.title)
                        if !(expense.comment?.isEmpty ?? true) {
                            ExpenseDetailRowInfo(key: "comment",
                                                 value: expense.comment ?? "")
                        }
                        ExpenseDetailRowInfo(key: "date",
                                             value: expense.date.dateFromJSON()?.dayAndMonthString() ?? "")
                        ExpenseDetailRowInfo(key: "category",
                                             value: expense.expenseType.rawValue.capitalized)
                    }
                }

                if let unwrapped = $region.toUnwrapped(defaultValue: .init(.world)) {
                    MapPreviewCard(cardContext: .preview,
                                   region: unwrapped.wrappedValue) { _ in }
                }

                ButtonDestructive {
                    Label("delete", systemImage: "trash.fill")
                } action: {
                    showAlert = true
                }
                .padding()
            }
        }
        .background {
            Color.ui.background
                .ignoresSafeArea()
        }
        .alert("alert.delete.expense", isPresented: $showAlert, actions: {
            Button("no", role: .cancel) {}
            Button("yes", role: .destructive) {
                Task {
                    let service = ExpenseService()
                    try? await service.deleteExpense(expenseID: expense.id)
                    dismiss()
                }
            }
        })
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showEditSheet = true
                } label: {
                    Image(systemName: "pencil.circle.fill")
                }
            }
        }
        .onAppear {
            if let longitude = expense.longitude,
               let latitude = expense.latitude {
                region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
                                            latitudinalMeters: 700,
                                            longitudinalMeters: 700)
            }
        }
        .sheet(isPresented: $showEditSheet) {
            AddExpenseView(viewModel: .init(carDataStore: CarDataSource(carService: CarService()),
                                            expenseService: ExpenseService(),
                                            expense: expense))
        }
    }
}

struct ExpenseDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseDetailsView(expense: .mock)
    }
}

struct ExpenseDetailRowInfo: View {

    let key: LocalizedStringKey
    let value: String

    var body: some View {
        ZStack {
            HStack {
                Text(key)
                    .bold()
                Spacer()
                Text(value)
            }
            .padding()
        }
    }
}
