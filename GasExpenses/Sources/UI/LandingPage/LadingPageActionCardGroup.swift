//
//  LadingPageActionCardGroup.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 08/04/2023.
//

import SwiftUI

struct LadingPageActionCardGroup: View {

    let carID: Int

    var body: some View {
            Grid {
                GridRow {
                    NavigationLink {
                        AddRefuelView(viewModel: .init(service: RefuelService(),
                                                       carID: carID))
                    } label: {
                        ActionCard(title: "landingPage.actionCard.addFuel",
                                   imageSystemName: "fuelpump.fill")
                    }

                    NavigationLink {
                        AddExpenseView(viewModel: AddExpenseViewModel(carDataStore: CarDataSource(carService: CarService()),
                                                                      expenseService: ExpenseService()))
                    } label: {
                        ActionCard(title: "landingPage.actionCard.addExpense",
                                   imageSystemName: "wrench.and.screwdriver.fill")
                    }
                }
                GridRow {
                    ActionCard(title: "landingPage.actionCard.seeNearbyGasStations",
                               imageSystemName: "map.fill")
                    ActionCard(title: "landingPage.actionCard.scanRecipt",
                               imageSystemName: "doc.viewfinder.fill")
                }
            }
            .foregroundColor(.blue)
            .padding()
    }
}

struct LadingPageActionCardGroup_Previews: PreviewProvider {
    static var previews: some View {
        LadingPageActionCardGroup(carID: 0)
    }
}
