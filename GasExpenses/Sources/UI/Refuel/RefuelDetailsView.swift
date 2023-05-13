//
//  RefuelDetailsView.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 12/05/2023.
//

import SwiftUI
import CoreLocation
import MapKit

struct RefuelDetailsView: View {
    @State private var showEditSheet: Bool = false
    @State private var showAlert: Bool = false
    @State private var region: MKCoordinateRegion?
    @State private var imageData: Data?
    let refuel: Refuel

    @EnvironmentObject private var carDataSource: CarDataSource

    var body: some View {

        ScrollView(showsIndicators: false) {
            VStack {
                TitleAndIconHeaderView(title: "expenses.details") {
                    EmptyView()
                }
                CardWithTitleView(title: "\(refuel.title)") {
                    VStack {
                        ExpenseDetailRowInfo(key: "amount",
                                             value: refuel.getTotalRefuelValue().currencyString() ?? "")
                        ExpenseDetailRowInfo(key: "title",
                                             value: refuel.title)
                        if !(refuel.comment?.isEmpty ?? true) {
                            ExpenseDetailRowInfo(key: "comment",
                                                 value: refuel.comment ?? "")
                        }
                        ExpenseDetailRowInfo(key: "date",
                                             value: refuel.date.dateFromJSON()?.dayAndMonthString() ?? "")
                    }
                }

                if let unwrapped = $region.toUnwrapped(defaultValue: .init(.world)) {
                    MapPreviewCard(region: unwrapped.wrappedValue) { _ in }
                }

                if $imageData.wrappedValue != nil {
                    ImagePreviewCard(imageData: $imageData)
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
            Button("yes", role: .destructive) {}
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
            imageData = Data(base64Encoded: refuel.documentBase64 ?? "")

            if let longitude = refuel.longitude,
               let latitude = refuel.latitude {
                region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
                                            latitudinalMeters: 700,
                                            longitudinalMeters: 700)
            }
        }
        .sheet(isPresented: $showEditSheet) {
            AddRefuelView(viewModel: AddRefuelViewModel(service: RefuelService(),
                                                        carID: carDataSource.selectedCar?.id ?? -1,
                                                        refuelID: refuel.id),
                          refuel: refuel)

        }
    }
}

struct RefuelDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RefuelDetailsView(refuel: .mock)
    }
}
