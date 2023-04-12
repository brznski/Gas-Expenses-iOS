//
//  FuelTypeIcon.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 12/04/2023.
//

import SwiftUI

struct FuelTypeIcon: View {
    let fuelType: FuelTypes
    var body: some View {
        switch fuelType {
        case .electic:
            Image(systemName: "bolt.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.yellow)
        case .lpg:
            Image(systemName: "leaf.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.blue)
        case .on:
            Image(systemName: "fuelpump.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.black)
        case .pb95:
            Image(systemName: "fuelpump.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.green)
        case .pb98:
            Image(systemName: "fuelpump.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.green)
        }
    }
}

struct FuelTypeIcon_Previews: PreviewProvider {
    static var previews: some View {
        FuelTypeIcon(fuelType: .lpg)
    }
}
