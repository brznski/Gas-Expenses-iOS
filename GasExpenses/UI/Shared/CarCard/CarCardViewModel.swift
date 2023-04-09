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
        let fuelConsumptionDifferenceSinceLast = model.fuelConsumptionDifferenceSinceLast()
        
        configureOdometerRowInfo()
        carInfoRows.append(CarCardInfoRowConfiguration(iconName: "calendar", text: "13th July 2023", helpText: "", isPositive: nil))
        carInfoRows.append(CarCardInfoRowConfiguration(iconName: "fuelpump.fill",
                                                       text: String(format: "%.2f l/100km", model.averageFuelConsumptionSinceLast()),
                                                       helpText: String(format: "%.2f l/100km", fuelConsumptionDifferenceSinceLast),
                                                       isPositive: fuelConsumptionDifferenceSinceLast < 0))
    }
    
    func getCarName() -> LocalizedStringKey {
        return model.name
    }
    
    private func configureOdometerRowInfo() {
        let numberFormatter = NumberFormatter()
        numberFormatter.groupingSeparator = ","
        numberFormatter.decimalSeparator = "."
        numberFormatter.groupingSize = 3
        numberFormatter.maximumFractionDigits = 1
        numberFormatter.numberStyle = .decimal
        numberFormatter.usesGroupingSeparator = true
        guard let mileage = model.refuels.last?.mileage else { return }
        let formattedMileage = numberFormatter.string(from: mileage as NSNumber)
        carInfoRows.append(CarCardInfoRowConfiguration(iconName: "gauge", text: "\(formattedMileage ?? "") km", helpText: "+\(Int(model.distanceDifferenceSinceLast())) km", isPositive: nil))
    }
}
