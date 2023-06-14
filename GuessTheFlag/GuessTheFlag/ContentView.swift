//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Gabriel on 24/04/23.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

struct FlagImage: View {
    let country: String
    
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white horizontal stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    
    var body: some View {
        Image(country)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
            .accessibilityLabel(labels[country, default: "Unknown flag"])
    }
}

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var restartGame = false
    @State private var rounds = 0
    
    @State private var flagsNotChosen = [0, 1, 2]
    @State private var buttonOpacityAnimation = [1.0, 1.0, 1.0]
    @State private var scaleAnimation = [1.0, 1.0, 1.0]
    @State private var rotationAngleAnimation = [0.0, 0.0, 0.0]
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            withAnimation {
                                flagTapped(number)
                            }
                        } label: {
                            FlagImage(country: countries[number])
                        }
                        .rotation3DEffect(.degrees(rotationAngleAnimation[number]), axis: (x: 0, y: 1, z: 0))
                        .opacity(buttonOpacityAnimation[number])
                        .scaleEffect(scaleAnimation[number])
                        
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: playAgain)
        } message: {
            Text("Your score is \(score)")
        }
        .alert("Congratulations", isPresented: $restartGame) {
            Button("Restart game", action: playAgain)
        } message: {
            Text("Your final score is \(score)")
        }
    }
    
    func flagTapped(_ number: Int) {
        withAnimation(.easeOut) {
            rotationAngleAnimation[number] = 360
            
            flagsNotChosen.remove(at: number)
            buttonOpacityAnimation[flagsNotChosen[0]] = 0.25
            buttonOpacityAnimation[flagsNotChosen[1]] = 0.25
            scaleAnimation[flagsNotChosen[0]] = 0.0
            scaleAnimation[flagsNotChosen[1]] = 0.0
        }
        
        rounds += 1
        
        if number == correctAnswer {
            score += 1
            scoreTitle = "Correct"
        } else {
            scoreTitle = "Wrong! That’s the flag of \(countries[number])"
        }
        
        if rounds >= 8 {
            restartGame = true
        } else {
            showingScore = true
        }
    }
    
    func playAgain() {
        flagsNotChosen = [0, 1, 2]
        rotationAngleAnimation = [0.0, 0.0, 0.0]
        buttonOpacityAnimation = [1.0, 1.0, 1.0]
        scaleAnimation = [1.0, 1.0, 1.0]
        
        if rounds >= 8 {
            score = 0
            rounds = 0
        }
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
