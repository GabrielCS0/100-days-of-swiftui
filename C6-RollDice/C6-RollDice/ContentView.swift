//
//  ContentView.swift
//  RollDice
//
//  Created by Gabriel on 27/06/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                VStack {
                    Text("Result:")
                        .font(.title)
                        
                    
                    if let resultNumber = viewModel.diceResult?.number {
                        Text(resultNumber, format: .number)
                            .font(.title)
                    } else { Text("") }
                }
                
                Spacer()
                
                Button("Roll Dice") { viewModel.rollDice() }
                    .padding()
                    .background(.green)
                    .foregroundColor(.white)
                    .font(.title)
                    .cornerRadius(12)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.isShowingPreviousResultsScreen = true
                    } label: {
                        Label("Previous Results", systemImage: "pencil.circle")
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Number of sides: \(viewModel.numberOfSides)")
                        .font(.callout)
                        .foregroundColor(.secondary)
                }
            }
            .sheet(isPresented: $viewModel.isShowingPreviousResultsScreen) {
                PreviousResultsView(diceResults: viewModel.diceResults, selectedNumberOfSides: $viewModel.numberOfSides)
            }
            .onAppear { viewModel.feedback.prepare() }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
