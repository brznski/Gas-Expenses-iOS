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

    var refuelID: Int?
    let carID: Int

    @Published var date: Date = .now
    @Published var title: String = ""
    @Published var comment: String = ""
    @Published var mileage: String = ""
    @Published var fuelAmount: String = ""
    @Published var costPerUnit: String = ""
    @Published var usersLocation: CLLocationCoordinate2D?
    @Published var documentBase64: Data?

    private let service: RefuelServiceProtocol

    init(service: RefuelServiceProtocol,
         carID: Int) {
        self.service = service
        self.carID = carID
    }

    init(service: RefuelServiceProtocol,
         carID: Int,
         refuelID: Int) {
        self.service = service
        self.carID = carID
        self.refuelID = refuelID
    }

    func addRefuel() {
        Task {
            let newRefuel = Refuel(id: 0,
                                   title: title, date: date.JSONDate(),
                                   comment: comment,
                                   mileage: Double(mileage)!,
                                   fuelAmount: Double(fuelAmount)!,
                                   costPerUnit: Double(costPerUnit.replacingOccurrences(of: ",", with: "."))!,
                                   latitude: usersLocation?.latitude.magnitude,
                                   longitude: usersLocation?.longitude.magnitude,
                                   documentBase64: documentBase64?.base64EncodedString())
            do {
                try await service.addRefuel(newRefuel,
                                            carID: carID)
            } catch {

            }
        }
    }
}
