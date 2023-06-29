//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Gabriel on 29/06/23.
//

import Foundation

class Favorites: ObservableObject {
    private var resorts: Set<String>
    private let saveKey = "Favorites"
    
    init() {
        if let favoritesData = UserDefaults.standard.data(forKey: saveKey) {
            if let favorites = try? JSONDecoder().decode(Set<String>.self, from: favoritesData) {
                resorts = favorites
                return
            }
        }
        
        resorts = []
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        if let favoritesEncoded = try? JSONEncoder().encode(resorts) {
            UserDefaults.standard.set(favoritesEncoded, forKey: saveKey)
        }
    }
}
