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
                        Label("Cars",
                              systemImage: "car.fill")
                    }
                    .tag("Cars")
                LandingPageView(viewModel: LandingPageViewModel())
                    .tabItem {
                        Label("Home",
                              systemImage: "house.fill")
                    }
                    .tag("Home")
                ExpensesOverviewView(viewModel: ExpensesOverviewViewModel())
                    .tabItem {
                        Label("Expenses",
                              systemImage: "dollarsign.circle.fill")
                    }
                    .tag("Expenses")
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
