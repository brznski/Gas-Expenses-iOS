//
//  TripCalculatorView.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 14/05/2023.
//

import SwiftUI

struct TripCalculatorView: View {
    @State private var averageConsumption: Double = 3
    @State private var costPerUnit: Double = 6
    @State private var tripCost: Double?
    var body: some View {
        ScrollView {
            VStack {
                CardWithTitleView(title: "trip.calculator.header") {
                    VStack {
                        TitleAndTextField(title: "average.consumption",
                                          textFieldValue: .constant(""))
                        TitleAndTextField(title: "cost.per.unit",
                                          textFieldValue: .constant(""))
                        ButtonPrimary {
                            Label("calculate", systemImage: "equal")
                        } action: {
                            tripCost = averageConsumption * costPerUnit
                        }
                    }
                    .padding()
                }
                Text("Your trip will cost \($tripCost.wrappedValue?.currencyString() ?? "")")
                    .multilineTextAlignment(.center)
            }
        }
        .background {
            Color.ui.background
                .ignoresSafeArea()
        }
    }
}

struct TripCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        TripCalculatorView()
    }
}
