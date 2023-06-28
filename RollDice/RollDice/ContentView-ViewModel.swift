//
//  ContentView-ViewModel.swift
//  RollDice
//
//  Created by Gabriel on 27/06/23.
//

import Foundation
import SwiftUI

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published var diceResults: [DiceResult]
        @Published var diceResult: DiceResult?
        @Published var numberOfSides = 6
        @Published var isShowingPreviousResultsScreen = false
        @Published var feedback = UINotificationFeedbackGenerator()
        
        let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedDiceResults")
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                diceResults = try JSONDecoder().decode([DiceResult].self, from: data)
            } catch {
                diceResults = []
            }
        }
        
        private func save() {
            do {
                let data = try JSONEncoder().encode(diceResults)
                try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
            } catch {
                print("Unable to save data")
            }
        }
        
        func rollDice() {
            let numbers = 1...numberOfSides
            let shuffledNumbers = numbers.shuffled()
            
            feedback.notificationOccurred(.success)
            diceResult = DiceResult(number: shuffledNumbers[0], numberOfSides: numberOfSides)
            diceResults.append(diceResult ?? DiceResult(number: -1, numberOfSides: -1))
            save()
        }
    }
}
