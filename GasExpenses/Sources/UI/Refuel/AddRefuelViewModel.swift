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
    @Published var title: String = ""
    @Published var comment: String = ""
    @Published var mileage: String = ""
    @Published var fuelAmount: String = ""
    @Published var costPerUnit: String = ""
    @Published var usersLocation: CLLocationCoordinate2D?
    @Published var documentBase64: Data?

    let context: AddExpenseViewContext
    private let service: RefuelServiceProtocol
    var refuelID: Int?
    let carID: Int

    init(service: RefuelServiceProtocol,
         carID: Int,
         context: AddExpenseViewContext) {
        self.service = service
        self.carID = carID
        self.context = context
    }

    init(service: RefuelServiceProtocol,
         carID: Int,
         refuelID: Int,
         context: AddExpenseViewContext) {
        self.service = service
        self.carID = carID
        self.refuelID = refuelID
        self.context = context
    }

    func sumbit() async {
            context == .add ? await addRefuel() : await editRefuel()
    }

    private func addRefuel() async  {
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

    private func editRefuel() async {
        let newRefuel = Refuel(id: refuelID ?? -1,
                               title: title, date: date.JSONDate(),
                               comment: comment,
                               mileage: Double(mileage)!,
                               fuelAmount: Double(fuelAmount)!,
                               costPerUnit: Double(costPerUnit.replacingOccurrences(of: ",", with: "."))!,
                               latitude: usersLocation?.latitude.magnitude,
                               longitude: usersLocation?.longitude.magnitude,
                               documentBase64: documentBase64?.base64EncodedString())
        do {
            try await service.editRefuel(newRefuel)
        } catch {

        }
    }
}
