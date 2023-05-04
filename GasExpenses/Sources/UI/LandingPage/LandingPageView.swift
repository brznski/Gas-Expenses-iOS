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

    var body: some View {
        NavigationView {
            ZStack {
                Color.ui.background
                    .ignoresSafeArea()
                ScrollView(showsIndicators: false) {
                    VStack {
                        TitleAndIconHeaderView(title: "my.overview") {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                        }
                        if let model = $viewModel.selectedCar.wrappedValue {
                            CarCardView(viewModel: .init(car: model), car: model, cardContext: .landingPage) {
                                shouldShowSheet.toggle()
                            }
                        }
                        LadingPageActionCardGroup()
                    }
                }
            }
            .onAppear {
                viewModel.prepareModels()
            }
            .sheet(isPresented: $shouldShowSheet) {
                ForEach($viewModel.cars) { car in
                    CarRowInfoView(carModel: .constant(car.wrappedValue)) {
                        viewModel.selectedCar = car.wrappedValue
                    }
                }
                Spacer()
            }
        }
    }
}

struct LandingPageView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = LandingPageViewModel()
        LandingPageView(viewModel: viewModel)
    }
}
