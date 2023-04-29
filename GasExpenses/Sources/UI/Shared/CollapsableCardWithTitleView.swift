//
//  CollapsableCardWithTitleView.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 12/04/2023.
//

import SwiftUI

struct CollapsableCardWithTitleView<Content: View>: View {
    let title: LocalizedStringKey
    let cardContent: (() -> Content)?
    let alignment: HorizontalAlignment

    @State var shouldShowContent = true

    init(title: LocalizedStringKey, alignment: HorizontalAlignment = .center, cardContent: ( () -> Content)?) {
        self.title = title
        self.alignment = alignment
        self.cardContent = cardContent
    }

    init(title: String, alignment: HorizontalAlignment = .center, cardContent: ( () -> Content)?) {
        self.title = LocalizedStringKey(title)
        self.alignment = alignment
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
                    Button {
                        withAnimation {
                            shouldShowContent.toggle()
                        }
                    } label: {
                        Image(systemName: shouldShowContent ? "chevron.down" : "chevron.up")
                    }
                    .tint(Color.ui.action)
                    .padding()

                }
                if shouldShowContent {
                    cardContent?()
                }
            }.padding()
        }
    }
}

struct CollapsableCardWithTitleView_Previews: PreviewProvider {
    static var previews: some View {
        CollapsableCardWithTitleView(title: "", cardContent: {
            Text("")
        })
    }
}
