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

    let mapLocations = [
            MapLocation(name: "St Francis Memorial Hospital", latitude: 37.789467, longitude: -122.416772),
            MapLocation(name: "The Ritz-Carlton, San Francisco", latitude: 37.791965, longitude: -122.406903),
            MapLocation(name: "Honey Honey Cafe & Crepery", latitude: 37.787891, longitude: -122.411223)
            ]

    let expense: Expense

    @State private var region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: 37.789467,
                    longitude: -122.416772),
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

                        CardWithTitleView(title: "map") {
                            Map(coordinateRegion: $region,
                                showsUserLocation: true,
                                annotationItems: mapLocations) { location in
                                MapAnnotation(coordinate: location.coordinate) {
                                    Image(systemName: "fuelpump.circle.fill")
                                        .tint(.ui.action)
                                    Text("\(location.name)")
                                }
                            }
                                .frame(minHeight: 300)
                        }
                    }
                }
            }
        }
    }
}

struct ExpenseDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseDetailsView(expense: .init(id: 0,
                                          amount: 3.70,
                                          title: "Test expense",
                                          date: "2022-03-15",
                                          expenseType: .wash))
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
