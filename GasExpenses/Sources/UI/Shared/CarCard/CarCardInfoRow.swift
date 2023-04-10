//
//  CarCardInfoRow.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 08/04/2023.
//

import SwiftUI

struct CarCardInfoRow: View {
    let configuration: CarCardInfoRowConfiguration
    
    var body: some View {
        HStack {
            Label(configuration.text,
                  systemImage: configuration.iconName)
                .font(.title2)
                .padding()
            Text(configuration.helpText)
                .font(.callout)
                .opacity(0.5)
            
            if configuration.isPositive == nil {
                EmptyView()
            } else if configuration.isPositive ?? true {
                ZStack {
                    Image(systemName: "arrow.down")
                        .foregroundColor(.ui.success)
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.ui.success, lineWidth: 1)
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.ui.success)
                        .frame(width: 25, height: 25)
                        .opacity(0.5)
                }
            } else {
                ZStack {
                    Image(systemName: "arrow.up")
                        .foregroundColor(.ui.warning)
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.ui.warning, lineWidth: 1)
                        .frame(width: 25, height: 25)
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.ui.warning)
                        .opacity(0.5)
                }
            }
            Spacer()
        }
    }
}

struct CardCardInfoRow_Previews: PreviewProvider {
    static var previews: some View {
        CarCardInfoRow(configuration: .init(iconName: "gauge", text: "200.000km", helpText: "+ 350 km", isPositive: nil))
    }
}
