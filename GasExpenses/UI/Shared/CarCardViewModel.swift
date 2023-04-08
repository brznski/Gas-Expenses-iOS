//
//  CarCardViewModel.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 08/04/2023.
//

import SwiftUI

final class CarCardViewModel: ObservableObject {
    private let model: Car
    @Published var carInfoRows = [CarCardInfoRowConfiguration]()
    
    init(model: Car) {
        self.model = model
        
        carInfoRows.append(CarCardInfoRowConfiguration(iconName: "gauge", text: "235,215 km", helpText: "+200 km", isPositive: nil))
        carInfoRows.append(CarCardInfoRowConfiguration(iconName: "calendar", text: "13th July 2023", helpText: "", isPositive: nil))
        carInfoRows.append(CarCardInfoRowConfiguration(iconName: "fuelpump.fill", text: "7.9 l/100km", helpText: "- 1 l/100km", isPositive: true))
    }
    
    func getCarName() -> LocalizedStringKey {
        return model.name
    }
}
