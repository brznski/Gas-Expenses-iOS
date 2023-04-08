//
//  CardCardInfoRow.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 08/04/2023.
//

import SwiftUI

struct CardCardInfoRow: View {
    let configuration: CarCardInfoRowConfiguration
    
    var body: some View {
        HStack {
            Label(configuration.text,
                  systemImage: configuration.iconName)
                .font(.title2)
                .padding()
            Text(configuration.helpText)
                .font(.body)
                .opacity(0.5)
            
            if configuration.isPositive == nil {
                EmptyView()
            } else if configuration.isPositive ?? true {
                ZStack {
                    Image(systemName: "arrow.down")
                        .foregroundColor(Color("Success"))
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color("Success"), lineWidth: 1)
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color("Success"))
                        .frame(width: 25, height: 25)
                        .opacity(0.5)
                }
            } else {
                ZStack {
                    Image(systemName: "arrow.up")
                        .foregroundColor(Color("Warning"))
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color("Warning"), lineWidth: 1)
                        .frame(width: 25, height: 25)
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color("Warning"))
                        .opacity(0.5)
                }
            }
            Spacer()
        }
    }
}

struct CardCardInfoRow_Previews: PreviewProvider {
    static var previews: some View {
        CardCardInfoRow(configuration: .init(iconName: "gauge", text: "200.000km", helpText: "+ 350 km", isPositive: nil))
    }
}
