//
//  CarOverviewView.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 12/04/2023.
//

import SwiftUI

struct CarOverviewView: View {
    @State var isSheetPresented = false
    @State var car: Car = .init(id: 1, name: "", brand: "", model: "", refuels: [], fuelType: .pb95, isFavourite: false, imageBase64: "")


    var body: some View {
        ScrollView {
            VStack {
                TitleAndIconHeaderView(title: "My cars") {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .onTapGesture {
                            isSheetPresented.toggle()
                        }
                }

                CarCardView(viewModel: .init(car: car), car: car)
            }
        }
        .background(Color.ui.background)
        .sheet(isPresented: $isSheetPresented, content: {
            AddCarView()
        })
    }
}

struct CarOverviewView_Previews: PreviewProvider {
    static var previews: some View {
        CarOverviewView()
    }
}
