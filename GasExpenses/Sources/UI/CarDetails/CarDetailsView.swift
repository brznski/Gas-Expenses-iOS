//
//  CarDetailsView.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 12/04/2023.
//

import SwiftUI
import Charts

struct CarDetailsView: View {
    @ObservedObject var viewModel: CarDetailsViewModel

    @State var showsAlert = false
    @State var shouldShowSheet = false

    var body: some View {
        ScrollView {
            VStack {
                CarCardView(viewModel: .init(car: viewModel.model,
                                             carService: ServiceLocator.shared.getCarService()),
                            cardContext: .carDetails)
                CardWithTitleView(title: "Gas expenses") {
                    Group {
                        if viewModel.model.refuels.count < 3 {
                            PlaceholderTextView(text: "car.card.refuel.empty")
                                .padding([.horizontal, .bottom])
                        } else {
                            Chart {
                                ForEach(viewModel.model.refuels.sorted(by: { lhs, rhs in
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
                        if viewModel.model.refuels.count < 3 {
                            PlaceholderTextView(text: "car.card.refuel.empty")
                                .padding([.horizontal, .bottom])
                        } else {
                            Chart {
                                ForEach(viewModel.model.refuels) { refuel in
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
                        ForEach($viewModel.remindersConfig) { configuration in
                            ReminderRowView(configuration: configuration.wrappedValue)
                        }
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
        .task {
            if viewModel.remindersConfig.isEmpty {
                viewModel.prepareRemindersConfig()
            }
        }
        .sheet(isPresented: $shouldShowSheet, content: {
            AddCarView(viewModel: .init(carService: ServiceLocator.shared.getCarService(),
                                        car: viewModel.model))
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
                viewModel.deleteCar(carID: viewModel.model.id)
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
        CarDetailsView(viewModel: .init(carService: ServiceLocator.shared.getCarService(), car: .mock))
        .environmentObject(CarDataSource(carService: ServiceLocator.shared.getCarService()))
    }
}
