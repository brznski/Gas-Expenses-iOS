//
//  CarOverviewView.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 12/04/2023.
//

import SwiftUI

struct CarOverviewView: View {
    @State var isSheetPresented = false
    @EnvironmentObject var carDataSource: CarDataSource

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    TitleAndIconHeaderView(title: "my.cars") {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .onTapGesture {
                                isSheetPresented.toggle()
                            }
                    }

                    if let models = $carDataSource.cars.wrappedValue,
                       !models.isEmpty {
                        ForEach(models) { model in
                            CarCardView(viewModel: .init(car: model,
                                                         carService: ServiceLocator.shared.getCarService()),
                                        cardContext: .carOverview)
                        }
                    } else {
                        PlaceholderTextView(text: "car.card.refuel.empty")
                    }
                }
            }
            .background(Color.ui.background)
            .sheet(isPresented: $isSheetPresented, content: {
                AddCarView(viewModel: .init(carService: ServiceLocator.shared.getCarService()))
            })
        }
    }
}

struct CarOverviewView_Previews: PreviewProvider {
    static var previews: some View {
        CarOverviewView()
    }
}
