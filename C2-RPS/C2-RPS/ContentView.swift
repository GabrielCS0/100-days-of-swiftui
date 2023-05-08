//
//  ContentView.swift
//  C2-RPS
//
//  Created by Gabriel on 05/05/23.
//

import SwiftUI

struct ContentView: View {
    @State private var appMove = Int.random(in: 0..<3)
    @State private var playerShouldWin = Bool.random()
    @State private var showEndGameAlert = false
    @State private var score = 0
    @State private var rounds = 0
    
    let gameMoveOptions = ["Rock", "Paper", "Scissors"]
    
    
    var body: some View {
        VStack {
            Text("Your score: \(score)")
            Text("App's move: \(gameMoveOptions[appMove])")
            Text("You must \(playerShouldWin ? "win" : "lose") this match to score")
            
            HStack {
                ForEach(gameMoveOptions, id: \.self) { move in
                    Button {
                        playerMove(move: move)
                    } label: {
                        Text(move)
                    }
                    .font(.system(size: 24))
                }
            }
        }
        .font(.system(size: 26))
        .multilineTextAlignment(.center)
        .alert("End of the game", isPresented: $showEndGameAlert) {
            Button("Play again", action: resetGame)
        } message: {
            Text("Your final score is \(score)")
        }
    }
    
    func playerMove(move: String) {
        rounds += 1
        let winningMoves = ["Paper", "Scissors", "Rock"]
        let playerMove = winningMoves.firstIndex(of: move)!
        
        if (appMove == playerMove && playerShouldWin) || (appMove != playerMove && !playerShouldWin) {
            score += 1
        } else {
            if score > 0 { score -= 1 }
        }
        
        if rounds >= 10 { showEndGameAlert = true }

        appMove = Int.random(in: 0..<3)
        playerShouldWin.toggle()
    }
    
    func resetGame() {
        score = 0
        rounds = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
