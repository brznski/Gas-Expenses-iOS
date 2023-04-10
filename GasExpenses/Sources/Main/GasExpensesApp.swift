//
//  GasExpensesApp.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 08/04/2023.
//

import SwiftUI

@main
struct GasExpensesApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                ContentView()
                    .tabItem {
                        Label("Cars",
                              systemImage: "car.fill")
                    }
                LandingPageView(viewModel: LandingPageViewModel())
                    .tabItem {
                        Label("Home",
                              systemImage: "house.fill")
                    }
                ContentView()
                    .tabItem {
                        Label("Expenses",
                              systemImage: "dollarsign.circle.fill")
                    }
            }
        }
    }
}
