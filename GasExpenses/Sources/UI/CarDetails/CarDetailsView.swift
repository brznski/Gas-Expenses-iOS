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
    let viewModel: CarDetailsViewModel
    @State var showsAlert = false

    var body: some View {
        ScrollView {
            VStack {
                CarCardView(viewModel: .init(car: model,
                                             carService: CarService()),
                            cardContext: .carOverview)
                CardWithTitleView(title: "Gas expenses") {
                    Chart {
                        ForEach(model.refuels.sorted(by: { lhs, rhs in
                            lhs.date.dateFromJSON()! < rhs.date.dateFromJSON()!
                        })) { refuel in
                            BarMark(
                                x: .value("date",
                                          refuel.date.dateFromJSON()?.dayAndMonthString() ?? ""),
                                y: .value("",
                                          refuel.fuelAmount * refuel.costPerUnit)
                            )
                        }
                    }
                    .padding()
                }
                CardWithTitleView(title: "mileage") {
                    Chart {
                        ForEach(model.refuels) { refuel in
                            BarMark(
                                x: .value("date",
                                          refuel.date.dateFromJSON()?.dayAndMonthString() ?? ""),
                                y: .value("",
                                          refuel.mileage)
                            )
                        }
                    }
                    .padding()
                }
                Button {
                    showsAlert = true
                } label: {
                    Spacer()
                    Text("delete")
                    Spacer()
                }
                .tint(.ui.warning)
                .buttonStyle(.borderedProminent)
                .padding()

            }
        }
        .alert("alert.delete.car", isPresented: $showsAlert,
               actions: {
            Button("yes", role: .destructive

            ) {
                viewModel.deleteCar(carID: model.id)
                showsAlert = false
            }
            Button("no", role: .cancel) {
                showsAlert = false
            }
        })
        .background(Color.ui.background)
    }
}

struct CarDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CarDetailsView(model: .mock,
                       viewModel: .init(carService: CarService()))
    }
}
