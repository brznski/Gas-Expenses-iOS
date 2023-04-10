//
//  CardWithTitleView.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 08/04/2023.
//

import SwiftUI

struct CardWithTitleView<Content: View>: View {
    let title: LocalizedStringKey
    let cardContent: (() -> Content)?
    let alignment: HorizontalAlignment = .center
    
    init(title: LocalizedStringKey, cardContent: ( () -> Content)?) {
        self.title = title
        self.cardContent = cardContent
    }
    
    var body: some View {
        ZStack {
            Color.ui.background
                .ignoresSafeArea()
            RoundedRectangle(cornerRadius: 8)
                .padding()
                .foregroundColor(.ui.contentOnBackground)
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
        CardWithTitleView(title: "My car" ) {
            VStack {
                Text("landingPage.actionCard.seeNearbyGasStations")
            }
        }
    }
}
