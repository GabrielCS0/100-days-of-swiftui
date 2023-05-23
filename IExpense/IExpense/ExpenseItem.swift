//
//  ExpenseItem.swift
//  IExpense
//
//  Created by Gabriel on 22/05/23.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
