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

    private var mapLocations: [MapLocation] {
        [
            MapLocation(name: expense.title,
                        latitude: expense.latitude ?? 0,
                        longitude: expense.longitude ?? 0)
        ]
    }

    let expense: Expense

    @State private var region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: 0,
                    longitude: 0),
                span: MKCoordinateSpan(
                    latitudeDelta: 0.01,
                    longitudeDelta: 0.01)
                )

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
                        ExpenseDetailRowInfo(key: "date",
                                             value: expense.date.dateFromJSON()?.dayAndMonthString() ?? "")
                        ExpenseDetailRowInfo(key: "category",
                                             value: expense.expenseType.rawValue.capitalized)
                    }
                }

                if expense.latitude != nil && expense.longitude != nil {
                    CardWithTitleView(title: "map") {
                        Map(coordinateRegion: $region,
                            showsUserLocation: true,
                            annotationItems: mapLocations) { location in
                            MapAnnotation(coordinate: location.coordinate) {
                                ExpenseTypeIcon(expenseType: expense.expenseType)
                                Text("\(location.name)")
                            }
                        }
                            .frame(minHeight: 300)
                    }
                }
            }
        }
        .onAppear {
            region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: expense.latitude ?? 0,
                    longitude: expense.longitude ?? 0),
                span: MKCoordinateSpan(
                    latitudeDelta: 0.01,
                    longitudeDelta: 0.01)
                )
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
