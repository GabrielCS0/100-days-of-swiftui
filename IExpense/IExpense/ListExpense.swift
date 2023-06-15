//
//  ListExpense.swift
//  IExpense
//
//  Created by Gabriel on 23/05/23.
//

import SwiftUI

struct ListExpense: View {
    let expense: ExpenseItem
    let userCurrencyCode: String
    let amountTextColor: Color
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(expense.name)
                    .font(.headline)
                Text(expense.type)
            }
            .accessibilityElement()
            .accessibilityLabel("\(expense.name), \(expense.amount, format: .currency(code: userCurrencyCode))")
            .accessibilityHint(expense.type)
            
            Spacer()
            
            Text(expense.amount, format: .currency(code: userCurrencyCode))
                .foregroundColor(amountTextColor)
                .accessibilityHidden(true)
        }
    }
}

struct ListExpense_Previews: PreviewProvider {
    static var previews: some View {
        ListExpense(expense: ExpenseItem(name: "Lunch", type: "Personal", amount: 9), userCurrencyCode: "USD", amountTextColor: Color.green)
    }
}
