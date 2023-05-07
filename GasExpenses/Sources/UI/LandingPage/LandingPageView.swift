//
//  LandingPageView.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 08/04/2023.
//

import SwiftUI

struct LandingPageView: View {
    @ObservedObject var viewModel: LandingPageViewModel
    @State var shouldShowSheet: Bool = false
    @EnvironmentObject var carDataSource: CarDataSource

    var body: some View {
        NavigationView {
            ZStack {
                Color.ui.background
                    .ignoresSafeArea()
                ScrollView(showsIndicators: false) {
                    VStack {
                        TitleAndIconHeaderView(title: "my.overview") {
                            NavigationLink(destination: SettingsPage()) {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                            }
                        }
                        if let model = $carDataSource.selectedCar.wrappedValue {
                            CarCardView(viewModel: .init(car: model,
                                                         carService: CarService()),
                                        cardContext: .landingPage) {
                                shouldShowSheet.toggle()
                            }
                        }
                        LadingPageActionCardGroup()
                    }
                }
                .refreshable {
                    Cache.shared.invalidate(key: "cars")
                    Task {
                        try await carDataSource.getCars()
                    }
                }
            }
            .sheet(isPresented: $shouldShowSheet) {
                ForEach($carDataSource.cars) { car in
                    CarRowInfoView(carModel: car) {
                        carDataSource.selectedCar = car.wrappedValue
                    }
                }
                Spacer()
            }
        }
    }
}

struct LandingPageView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = LandingPageViewModel(carDataSource: CarDataSource(carService: CarService()))
        LandingPageView(viewModel: viewModel)
    }
}
