//
//  Activities.swift
//  MyHabitTracking
//
//  Created by Gabriel on 31/05/23.
//

import Foundation

class Activities: ObservableObject {
    @Published var habits = [Activity]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(habits) {
                UserDefaults.standard.set(encoded, forKey: "Habits")
            }
        }
    }
    
    init() {
        if let savedHabits = UserDefaults.standard.data(forKey: "Habits") {
            if let decodedHabits = try? JSONDecoder().decode([Activity].self, from: savedHabits) {
                habits = decodedHabits
                return
            }
        }
        
        habits = []
    }
}
