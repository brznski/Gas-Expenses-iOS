//
//  AddRefuelViewModel.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 11/05/2023.
//

import Foundation
import CoreLocation
import SwiftUI

final class AddRefuelViewModel: ObservableObject {
    @Published var date: Date = .now
    @Published var mileage: String = ""
    @Published var fuelAmount: String = ""
    @Published var costPerUnit: String = ""
    @Published var usersLocation: CLLocationCoordinate2D?

    @Binding var car: Car?
    private let service: RefuelServiceProtocol

    init(service: RefuelServiceProtocol,
         car: Binding<Car?>) {
        self.service = service
        self._car = car
    }

    func addRefuel() {
        Task {
            let newRefuel = Refuel(id: 0,
                                   date: date.JSONDate(),
                                   mileage: Double(mileage)!,
                                   fuelAmount: Double(fuelAmount)!,
                                   costPerUnit: Double(costPerUnit.replacingOccurrences(of: ",", with: "."))!,
                                   latitude: (usersLocation?.latitude.magnitude)!,
                                   longitude: (usersLocation?.longitude.magnitude)!)
            do {
                try await service.addRefuel(newRefuel,
                                            carID: car?.id ?? -1)
            } catch {

            }
        }
    }
}
