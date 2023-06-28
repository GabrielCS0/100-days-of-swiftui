//
//  DiceResult.swift
//  RollDice
//
//  Created by Gabriel on 27/06/23.
//

import Foundation

struct DiceResult: Codable, Identifiable {
    var id = UUID()
    let number: Int
    let numberOfSides: Int
    var date = Date()
    
    static let example = DiceResult(number: 5, numberOfSides: 6)
}
