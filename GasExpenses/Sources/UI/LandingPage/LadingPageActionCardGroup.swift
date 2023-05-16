//
//  LadingPageActionCardGroup.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 08/04/2023.
//

import SwiftUI

struct LadingPageActionCardGroup: View {

    @EnvironmentObject var carDataSource: CarDataSource

    var body: some View {
            Grid {
                GridRow {
                    NavigationLink {
                        AddRefuelView(viewModel: .init(service: ServiceLocator.shared.getRefuelService(),
                                                       carID: $carDataSource.selectedCar.wrappedValue?.id ?? -1, context: .add))
                    } label: {
                        ActionCard(title: "landingPage.actionCard.addFuel",
                                   imageSystemName: "fuelpump.fill")
                    }

                    NavigationLink {
                        AddExpenseView(viewModel: AddExpenseViewModel(carDataStore: carDataSource,
                                                                      expenseService: ExpenseService()))
                    } label: {
                        ActionCard(title: "landingPage.actionCard.addExpense",
                                   imageSystemName: "wrench.and.screwdriver.fill")
                    }
                }
                GridRow {
                    ActionCard(title: "landingPage.actionCard.seeNearbyGasStations",
                               imageSystemName: "map.fill")
                    NavigationLink(destination: TripCalculatorView()) {
                        ActionCard(title: "landingPage.actionCard.trip.calculator",
                                   imageSystemName: "plus.forwardslash.minus")
                    }

                }
            }
            .foregroundColor(.blue)
            .padding()
    }
}

struct LadingPageActionCardGroup_Previews: PreviewProvider {
    static var previews: some View {
        LadingPageActionCardGroup()
    }
}
