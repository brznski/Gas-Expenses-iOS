//
//  ExpensesOverviewView.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 11/04/2023.
//

import SwiftUI

struct ExpensesOverviewView: View {
    var body: some View {
        ZStack {
            Color.ui.background
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack {
                    TitleAndIconHeaderView<EmptyView>(title: "Expenses")
                    CardWithTitleView(title: "Recent expenses",
                                      alignment: .leading) {
                        Text("350,50 zł")
                            .font(.largeTitle)
                            .bold()
                            .padding()
                    }
                    ScrollView(.horizontal) {
                        HStack {
                            Button {

                            } label: {
                                Label("Filter", systemImage: "line.3.horizontal.decrease.circle.fill")
                            }
                            .buttonStyle(.borderedProminent)

                                Text("Above 150 zł")
                                .background(RoundedRectangle(cornerRadius: 8).fill(Color.ui.contentOnBackground))

                            Text("Above 150 zł")
                            .background(RoundedRectangle(cornerRadius: 8).fill(Color.ui.contentOnBackground))

                            Text("Above 150 zł")
                            .background(RoundedRectangle(cornerRadius: 8).fill(Color.ui.contentOnBackground))

                            Spacer()
                        }
                        .padding()
                    }

                    CardWithTitleView(title: "June 2023") {
                        VStack {
                            ExpenseRowView()
                            ExpenseRowView()
                        }
                    }
                }
            }
        }
    }
}

struct ExpensesOverviewView_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesOverviewView()
    }
}
