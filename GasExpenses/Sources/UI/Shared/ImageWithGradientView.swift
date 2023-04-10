//
//  ImageWithGradientView.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 08/04/2023.
//

import SwiftUI

struct ImageWithGradientView: View {
    let imageName: String
    var body: some View {
        ZStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
            LinearGradient(colors: [Color.ui.contentOnBackground, .clear], startPoint: .top, endPoint: .center)
            LinearGradient(colors: [Color.ui.contentOnBackground, .clear], startPoint: .bottom, endPoint: .center)
        }
    }
}

struct ImageWithGradientView_Previews: PreviewProvider {
    static var previews: some View {
        ImageWithGradientView(imageName: "car_image_test")
    }
}
