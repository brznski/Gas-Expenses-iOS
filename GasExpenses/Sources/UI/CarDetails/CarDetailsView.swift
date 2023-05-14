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
    @State var shouldShowSheet = false

    var body: some View {
        ScrollView {
            VStack {
                CarCardView(viewModel: .init(car: model,
                                             carService: CarService()),
                            cardContext: .carDetails)
                CardWithTitleView(title: "Gas expenses") {
                    Group {
                        if model.refuels.count < 3 {
                            Text("car.card.refuel.empty")
                                .padding([.horizontal, .bottom])
                                .multilineTextAlignment(.center)
                                .opacity(0.7)
                        } else {
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
                    }
                }
                CardWithTitleView(title: "mileage") {
                    Group {
                        if model.refuels.count < 3 {
                            Text("car.card.refuel.empty")
                                .padding([.horizontal, .bottom])
                                .multilineTextAlignment(.center)
                                .opacity(0.7)
                        } else {
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
                    }
                }

                CardWithTitleView(title: "reminders") {
                    VStack {
                        ReminderRowView(configuration: viewModel.getInsuraceReminderRowConfiguration())
                        ReminderRowView(configuration: viewModel.getTechnicalCheckupReminderRowConfiguration())
                    }
                    .padding()
                }

                ButtonDestructive {
                    Label("delete", systemImage: "trash")
                } action: {
                    showsAlert = true
                }
                .padding()
            }
        }
        .sheet(isPresented: $shouldShowSheet, content: {
            AddCarView(viewModel: .init(carService: CarService(),
                                        car: model))
        })
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    shouldShowSheet = true
                } label: {
                    Image(systemName: "pencil.circle.fill")
                }
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
        .environmentObject(CarDataSource(carService: CarService()))
    }
}
