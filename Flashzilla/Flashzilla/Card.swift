//
//  Card.swift
//  Flashzilla
//
//  Created by Gabriel on 23/06/23.
//

import Foundation

struct Card: Codable {
    let prompt: String
    let answer: String
    
    static let example = Card(prompt: "你好", answer: "Hello")
}
