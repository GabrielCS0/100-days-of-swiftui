//
//  User.swift
//  C4-ISocial
//
//  Created by Gabriel on 05/06/23.
//

import Foundation

struct User: Codable, Identifiable {
    let id: String
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: String
    let tags: [String]
    let friends: [Friend]
}

struct Friend: Codable, Identifiable {
    let id: String
    let name: String
}
