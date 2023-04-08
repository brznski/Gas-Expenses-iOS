//
//  CarCardViewModel.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 08/04/2023.
//

import Foundation

final class CarCardViewModel {
    private let model: Car
    
    init(model: Car) {
        self.model = model
    }
    
    func getCarName() -> String {
        return model.name
    }
}
