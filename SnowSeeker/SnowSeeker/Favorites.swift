//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Gabriel on 29/06/23.
//

import Foundation

class Favorites: ObservableObject {
    private var resorts: Set<String>
    private let savePath = FileManager.documentsDirectory.appendingPathComponent("Favorites")
    
    init() {
        do {
            let favoritesData = try Data(contentsOf: savePath)
            resorts = try JSONDecoder().decode(Set<String>.self, from: favoritesData)
        } catch {
            resorts = []
        }
    }
    
    func save() {
        do {
            let favoritesData = try JSONEncoder().encode(resorts)
            try favoritesData.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
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
}
