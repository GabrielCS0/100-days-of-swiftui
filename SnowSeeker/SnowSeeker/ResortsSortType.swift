//
//  ResortsSortType.swift
//  SnowSeeker
//
//  Created by Gabriel on 29/06/23.
//

import Foundation

class ResortsSortType: ObservableObject {
    @Published var type: String {
        didSet { save() }
    }
    
    private let saveKey = "SortType"
    
    init() {
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            if let typeDecoded = try? JSONDecoder().decode(String.self, from: data) {
                type = typeDecoded
                return
            }
        }
        
        type = "default"
    }
    
    private func save() {
        if let typeEncoded = try? JSONEncoder().encode(type) {
            UserDefaults.standard.set(typeEncoded, forKey: saveKey)
        }
    }
}
