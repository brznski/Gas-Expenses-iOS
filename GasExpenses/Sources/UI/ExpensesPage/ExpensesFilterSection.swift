//
//  ExpensesFilterSection.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 11/04/2023.
//

import SwiftUI

struct ExpenseFilter {
    let id = UUID()
    var amountFrom: String = ""
    var amountTo: String = ""
    var dateFrom: Date?
    var dateTo: Date?
    var title: String = ""
    var expenseType: String = ""
}

struct ExpenceFilterElement: Hashable {
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(text)
    }

    static func == (lhs: ExpenceFilterElement, rhs: ExpenceFilterElement) -> Bool {
        return lhs.text == rhs.text
    }

    let text: String
    let onDelete: () -> Void
}

struct ExpensesFilterSection: View {
    @ObservedObject var viewModel: ExpensesOverviewViewModel

    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                NavigationLink {
                    ExpenseFilterView(viewModel: viewModel)
                } label: {
                    Label("filter", systemImage: "line.3.horizontal.decrease.circle.fill")
                }
                .buttonStyle(.borderedProminent)
                .tint(.ui.action)

                HStack {
                    ForEach(prepareFilters(), id: \.self) { filter in
                        Text(filter.text)
                        Button {
                            withAnimation {
                                filter.onDelete()
                            }
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                        }
                        .tint(Color.ui.action)
                        .padding()
                    }
                }
            }
            .padding()
        }
    }

    private func prepareFilters() -> [ExpenceFilterElement] {
        var stringArray = [ExpenceFilterElement]()
        if !viewModel.filters.amountFrom.isEmpty {
            let localizedKey = String(localized: "above.%@")
            let formattedText = String(format: localizedKey, viewModel.filters.amountFrom)
            stringArray.append(.init(text: formattedText) {
                viewModel.filters.amountFrom = ""
            })
        }

        if !viewModel.filters.amountTo.isEmpty {
            let localizedKey = String(localized: "below.%@")
            let formattedText = String(format: localizedKey, viewModel.filters.amountTo)
            stringArray.append(.init(text: formattedText) {
                viewModel.filters.amountTo = ""
            })
        }

        if let dateFrom = viewModel.filters.dateFrom {
            let localizedKey = String(localized: "from.%@")
            let formattedText = String(format: localizedKey, dateFrom.dayAndMonthString())
            stringArray.append(.init(text: formattedText) {
                viewModel.filters.dateFrom = nil
            })
        }

        if let dateTo = viewModel.filters.dateTo {
            let localizedKey = String(localized: "to.%@")
            let formattedText = String(format: localizedKey, dateTo.dayAndMonthString())
            stringArray.append(.init(text: formattedText) {
                viewModel.filters.dateTo = nil
            })
        }

        if !viewModel.filters.expenseType.isEmpty {
            let localizedKey = String(localized: "type.%@")
            let formattedText = String(format: localizedKey, viewModel.filters.expenseType)
            stringArray.append(.init(text: formattedText) {
                viewModel.filters.expenseType = ""
            })
        }

        if !viewModel.filters.title.isEmpty {
            let localizedKey = String(localized: "contains %@")
            let formattedText = String(format: localizedKey, viewModel.filters.title)
            stringArray.append(.init(text: formattedText) {
                viewModel.filters.title = ""
            })
        }

        return stringArray
    }
}

struct ExpensesFilterSection_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesFilterSection(viewModel: .init(carID: 0,
                                               carDataSource: CarDataSource(carService: CarService()),
                                               refuelService: ServiceLocator.shared.getRefuelService()))
    }
}
