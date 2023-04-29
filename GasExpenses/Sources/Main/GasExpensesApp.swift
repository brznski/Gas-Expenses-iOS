//
//  GasExpensesApp.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 08/04/2023.
//

import SwiftUI

@main
struct GasExpensesApp: App {
    @State var selectedTab = "Home"

    var body: some Scene {
        WindowGroup {
            TabView(selection: $selectedTab) {
                CarOverviewView()
                    .tabItem {
                        Label("cars",
                              systemImage: "car.fill")
                    }
                    .tag("cars")
                LandingPageView(viewModel: LandingPageViewModel())
                    .tabItem {
                        Label("home",
                              systemImage: "house.fill")
                    }
                    .tag("home")
                ExpensesOverviewView(viewModel: ExpensesOverviewViewModel())
                    .tabItem {
                        Label("expenses",
                              systemImage: "dollarsign.circle.fill")
                    }
                    .tag("expenses")
            }
            .onAppear {
                Task {
                    do {
                        _ = try await JWTService().getJWT()
                    } catch {

                    }
                }
            }
            .tint(Color.ui.action)
        }
    }
}
