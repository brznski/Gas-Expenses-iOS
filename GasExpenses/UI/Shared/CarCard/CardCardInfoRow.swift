//
//  CardCardInfoRow.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 08/04/2023.
//

import SwiftUI

struct CardCardInfoRow: View {
    let labelText: String
    let labelImage: String
    let helpText: String
    let isPositive: Bool
    
    var body: some View {
        HStack {
            Label(labelText, systemImage: labelImage)
                .font(.title2)
                .padding()
            Text(helpText)
                .font(.body)
                .opacity(0.5)
            
            if isPositive {
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
            } else if !isPositive {
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
        CardCardInfoRow(labelText: "2", labelImage: "gauge", helpText: "2", isPositive: true)
    }
}
