//
//  AddCarViewModel.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 12/04/2023.
//

import Foundation

final class AddCarViewModel: ObservableObject {
    @Published var model: Car = .init(id: 1,
                                      name: "",
                                      brand: "",
                                      model: "",
                                      refuels: [],
                                      fuelType: .pb95,
                                      isFavourite: false,
                                      imageBase64: "")
}
