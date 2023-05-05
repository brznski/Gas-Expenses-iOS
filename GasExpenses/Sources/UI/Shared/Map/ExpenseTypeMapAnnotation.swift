//
//  ExpenseTypeMapAnnotation.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 05/05/2023.
//

import SwiftUI

struct ExpenseTypeMapAnnotation: View {

    let expenseType: ExpenseType
    let annotationTitle: String

    var body: some View {
        VStack(spacing: 4) {
            ExpenseTypeIcon(expenseType: expenseType)
            Text(annotationTitle)
                .bold()
        }
    }
}

struct ExpenseTypeMapAnnotation_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseTypeMapAnnotation(expenseType: .wash,
                                 annotationTitle: "Detailing")
            .previewLayout(.sizeThatFits)
    }
}
