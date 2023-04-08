//
//  CardWithTitleView.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 08/04/2023.
//

import SwiftUI

struct CardWithTitleView<Content: View>: View {
    let title: String
    let cardContent: (() -> Content)?
    let alignment: HorizontalAlignment = .center
    
    init(title: String, cardContent: ( () -> Content)?) {
        self.title = title
        self.cardContent = cardContent
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .padding()
                .foregroundColor(.gray)
            VStack(alignment: alignment) {
                HStack {
                    Text(title)
                        .font(.title).bold()
                        .padding()
                    Spacer()
                }
                cardContent?()
            }.padding()
        }
    }
}

struct CardWithTitleView_Previews: PreviewProvider {
    static var previews: some View {
        CardWithTitleView(title: "My card") {
            VStack {
                Text("My")
                Text("card")
                Text("content")
            }
        }
    }
}
