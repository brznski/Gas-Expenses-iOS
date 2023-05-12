//
//  ExpenseTypeIcon.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 05/05/2023.
//

import SwiftUI

struct ExpenseTypeIcon: View {

    let expenseType: ExpenseType

    private var primaryColor: Color {
        switch expenseType {
        case .wash:
            return .blue
        case .maintenance:
            return .orange
        case .insurance:
            return .yellow
        case .parts:
            return .gray
        case .fuel:
            return .orange
        case .undefinied:
            return .clear
        }
    }

    private var iconName: String {
        switch expenseType {
        case .insurance:
            return "umbrella.fill"
        case .maintenance:
            return "wrench.and.screwdriver.fill"
        case .parts:
            return "gearshape.fill"
        case .wash:
            return "sparkles"
        case .fuel:
            return "fuelpump.fill"
        case .undefinied:
            return ""
        }
    }

    var body: some View {
        ZStack {
            Circle()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50)
                .foregroundColor(primaryColor)
                .padding()
            Image(systemName: iconName)
                .foregroundColor(.white)
        }
    }
}

struct ExpenseTypeIcon_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseTypeIcon(expenseType: .wash)
            .previewDisplayName("Wash")
            .previewLayout(.sizeThatFits)
        ExpenseTypeIcon(expenseType: .parts)
            .previewDisplayName("Maintenance")
            .previewLayout(.sizeThatFits)
        ExpenseTypeIcon(expenseType: .insurance)
            .previewDisplayName("Insurance")
            .previewLayout(.sizeThatFits)
        ExpenseTypeIcon(expenseType: .maintenance)
            .previewDisplayName("Maintenance")
            .previewLayout(.sizeThatFits)
        ExpenseTypeIcon(expenseType: .fuel)
            .previewDisplayName("Fuel")
            .previewLayout(.sizeThatFits)
    }
}
