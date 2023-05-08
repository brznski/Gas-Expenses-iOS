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
    var title: String?
    var expenseType: ExpenseType?
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
            stringArray.append(.init(text: "Above \(viewModel.filters.amountFrom)", onDelete: {
                viewModel.filters.amountFrom = ""
            }))
        }

        if !viewModel.filters.amountTo.isEmpty {
            stringArray.append(.init(text: "Below \(viewModel.filters.amountTo)", onDelete: {
                viewModel.filters.amountTo = ""
            }))
                }

        if let dateFrom = viewModel.filters.dateFrom {
            stringArray.append(.init(text: "From \(dateFrom.monthAndYearString())",
                                     onDelete: {
                viewModel.filters.dateFrom = nil
            }))
        }

        if let dateTo = viewModel.filters.dateTo {
            stringArray.append(.init(text: "To \(dateTo.monthAndYearString())",
                                     onDelete: {
                viewModel.filters.dateTo = nil
            }))
        }

        if let expenseType = viewModel.filters.expenseType {
            stringArray.append(.init(text: "\(expenseType.rawValue)", onDelete: {
                viewModel.filters.expenseType = nil
            }))
        }

        if let title = viewModel.filters.title {
            stringArray.append(.init(text: "Contains \(title)", onDelete: {
                viewModel.filters.title = nil
            }))
        }

        return stringArray
    }
}

struct ExpensesFilterSection_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesFilterSection(viewModel: .init(carID: 0, carDataSource: CarDataSource(carService: CarService())))
    }
}
