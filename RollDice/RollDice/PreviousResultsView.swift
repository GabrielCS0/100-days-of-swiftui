//
//  PreviousResultsView.swift
//  RollDice
//
//  Created by Gabriel on 27/06/23.
//

import SwiftUI

struct PreviousResultsView: View {
    @Environment(\.dismiss) var dismiss
    
    let diceResults: [DiceResult]
    
    @Binding var selectedNumberOfSides: Int
    let numberOfSides = [4, 6, 8, 10, 12, 20, 100]
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Customize") {
                    Picker("Choose the number of sides", selection: $selectedNumberOfSides) {
                        ForEach(numberOfSides, id: \.self) {
                            Text($0, format: .number)
                        }
                    }
                }
                
                Section("Previous Results") {
                    if diceResults.isEmpty {
                        Text("Previous results will appear here!")
                    } else {
                        List(diceResults) { result in
                            VStack(alignment: .leading) {
                                Text("Dice result: \(result.number)")
                                    .font(.headline)
                                Text("Number of sides: \(result.numberOfSides)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                Text(result.date.formatted(date: .long, time: .shortened))
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
            .toolbar {
                Button("Done") {
                    dismiss()
                }
            }
        }
    }
}

struct PreviousResultsView_Previews: PreviewProvider {
    static var previews: some View {
        PreviousResultsView(diceResults: [DiceResult.example], selectedNumberOfSides: .constant(6))
    }
}
