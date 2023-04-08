//
//  TitleAndIconHeaderView.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 08/04/2023.
//

import SwiftUI

struct TitleAndIconHeaderView<Content: View>: View {
    private let title: String
    private let rightIcon: (() -> Content)?
    
    init(title: String,
         rightIcon: (() -> Content)? = nil) {
        self.title = title
        self.rightIcon = rightIcon
    }
    
    var body: some View {
        HStack {
            Text(title)
                .font(.largeTitle.bold())
            Spacer()
            rightIcon?()
        }
        .padding()
    }
}

struct TitleAndIconHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        TitleAndIconHeaderView(title: "My title") {
            Label("My icon", systemImage: "iphone")
        }
    }
}
