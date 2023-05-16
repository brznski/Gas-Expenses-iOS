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
                                                         carService: CarService()),
                                        cardContext: .carOverview)
                        }
                    } else {
                        Text("car.overview.car.list.empty")
                            .opacity(0.6)
                            .multilineTextAlignment(.center)
                    }
                }
            }
            .background(Color.ui.background)
            .sheet(isPresented: $isSheetPresented, content: {
                AddCarView()
            })
        }
    }
}

struct CarOverviewView_Previews: PreviewProvider {
    static var previews: some View {
        CarOverviewView()
    }
}
