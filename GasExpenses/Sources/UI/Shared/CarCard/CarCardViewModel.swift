//
//  CarCardViewModel.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 08/04/2023.
//

import SwiftUI

final class CarCardViewModel: ObservableObject {
    @Published var model: Car?
    @Published var carInfoRows = [CarCardInfoRowConfiguration]()
    @Published var carName: String = ""
    
    private let selectedCarDataStore: SelectedCarDataStoreProtocol
    
    init(selectedCarDataStore: SelectedCarDataStoreProtocol) {
        self.selectedCarDataStore = selectedCarDataStore
    }
    
    func getSelectedCar() {
        model = selectedCarDataStore.getSelectedCar()
        
        if let model {
            configureOdometerRowInfo()
            configureGasCostRowInfo()
            carInfoRows.append(CarCardInfoRowConfiguration(iconName: "fuelpump.fill",
                                                           text: String(format: "%.2f l/100km", model.averageFuelConsumptionSinceLast()),
                                                           helpText: String(format: "%.2f l/100km", model.fuelConsumptionDifferenceSinceLast()),
                                                           isPositive: model.fuelConsumptionDifferenceSinceLast() < 0))
        }
    }
    
    private func configureOdometerRowInfo() {

        carInfoRows.append(CarCardInfoRowConfiguration(iconName: "gauge",
                                                       text: "\(model?.refuels.last?.mileage.odometerString() ?? "") km",
                                                       helpText: "+\(Int(model?.distanceDifferenceSinceLast().odometerString() ?? "") ?? 0) km",
                                                       isPositive: nil))
    }
    
    private func configureGasCostRowInfo() {
        
        if let model {
            carInfoRows.append(CarCardInfoRowConfiguration(iconName: "dollarsign.circle",
                                                           text: "\(model.refuels.last?.costPerUnit.currencyString() ?? "") ",
                                                           helpText: "\(model.gasPerUnitPriceSinceLast().currencyString() ?? "")",
                                                           isPositive: model.gasPerUnitPriceSinceLast() < 0))
        }
    }
}