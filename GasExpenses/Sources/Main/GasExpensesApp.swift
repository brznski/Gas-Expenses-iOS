//
//  GasExpensesApp.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 08/04/2023.
//

import SwiftUI

@main
struct GasExpensesApp: App {
    @State var selectedTab = "home"
    @StateObject var carDataSource: CarDataSource = .init(carService: CarService())
    @StateObject var userManager = UserManager.shared
    @AppStorage("onboardingWasShown") private var shouldShowOnboarding = true

    var body: some Scene {
        WindowGroup {
            Group {
                if $userManager.isUserLoggedIn.wrappedValue {
                    TabView(selection: $selectedTab) {
                        CarOverviewView()
                            .tabItem {
                                Label("cars",
                                      systemImage: "car.fill")
                            }
                            .tag("cars")
                        LandingPageView(viewModel: LandingPageViewModel(carDataSource: carDataSource))
                            .tabItem {
                                Label("home",
                                      systemImage: "house.fill")
                            }
                            .tag("home")
                        ExpensesOverviewView(viewModel: ExpensesOverviewViewModel(carID: $carDataSource.selectedCar.wrappedValue?.id ?? -1, carDataSource: carDataSource))
                            .tabItem {
                                Label("expenses",
                                      systemImage: "dollarsign.circle.fill")
                            }
                            .tag("expenses")
                    }
                    .environmentObject(carDataSource)
                    .onAppear {
                        Task {
                            do {
                                _ = try await carDataSource.getCars()
                            } catch {

                            }
                        }
                    }
                    .tint(Color.ui.action)
                } else if $shouldShowOnboarding.wrappedValue {
                    OnboardingMainView()
                } else {
                    LoginMainPage(loginService: JWTService())
                }
            }.environmentObject(userManager)
        }
    }
}
