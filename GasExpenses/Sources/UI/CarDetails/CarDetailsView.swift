//
//  CarDetailsView.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 12/04/2023.
//

import SwiftUI
import Charts

struct CarDetailsView: View {
    let model: Car
    var body: some View {
        ScrollView {
            VStack {
                CarCardView(viewModel: .init(carService: CarDataSource()))
                CardWithTitleView(title: "Gas expenses") {
                    Chart {
                        ForEach(model.refuels) { refuel in
                            BarMark(
                                x: .value("Date", refuel.date),
                                y: .value("", refuel.fuelAmount * refuel.costPerUnit)
                            )
                        }
                    }
                    .padding()
                }
                CardWithTitleView(title: "Mileage") {
                    Chart {
                        ForEach(model.refuels) { refuel in
                            BarMark(
                                x: .value("Date", refuel.date),
                                y: .value("", refuel.mileage)
                            )
                        }
                    }
                    .padding()
                }
            }
        }
        .background(Color.ui.background)
    }
}

struct CarDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CarDetailsView(model: MockCarService().getFavouriteCar()!)
    }
}
