//
//  ReminderRowView.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 14/05/2023.
//

import SwiftUI

struct ReminderRowViewConfiguration {
    let date: Date
    let title: LocalizedStringKey
    let validUntilText: LocalizedStringKey
    let expiresInText: LocalizedStringKey
    let isButtonFilled: Bool
    let onClickButton: () -> Void
}

struct ReminderRowView: View {
    let configuration: ReminderRowViewConfiguration

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(configuration.title)
                    .bold()
                    .font(.title2)
                Spacer()
            }
            HStack {
                Text(configuration.validUntilText)
                    .bold()
                Spacer()
                Text("\(configuration.date.dayMonthAndYearString())")
            }
            HStack {
                Text(configuration.expiresInText)
                    .bold()
                Spacer()
                Text("\(configuration.date.relativeDate())")
            }
            HStack {
                Spacer()
                Button {

                } label: {
                    Label("remind.me",
                          systemImage: configuration.isButtonFilled ? "bell.fill" : "bell")
                }
                .buttonStyle(.borderedProminent)
                .tint(.ui.action)
            }
        }
    }
}

struct ReminderRowView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderRowView(configuration: .init(date: .now,
                                             title: "insurance",
                                             validUntilText: "insurance.valid.until",
                                             expiresInText: "insurance.expires.in",
                                            isButtonFilled: true) { })
            .previewLayout(.sizeThatFits)
    }
}
