//
//  ContentView.swift
//  C3-IMultiply
//
//  Created by Gabriel on 12/05/23.
//

import SwiftUI

struct GameView: View {
    let multiplicationTable: Int
    let numberOfQuestions: Int
    @Binding var settingsCompleted: Bool
    
    @State private var score = 0
    @State private var questionsAnsweredWrong = 0
    @State private var currentQuestionIndex = 1
    @State private var userAnswer = ""
    
    @State private var showingEndQuestionsAlert = false
    @State private var messageIfQuestionsAnsweredWrong = ""
    
    var body: some View {
        VStack {
            Text("\(multiplicationTable) x \(currentQuestionIndex) = ?")
                .font(.system(size: 50))
            
            TextField("Enter answer", text: $userAnswer)
                .keyboardType(.numberPad)
                .font(.system(size: 35))
                .frame(width: 200)
                .multilineTextAlignment(.center)
        }
        .alert("End of questions!", isPresented: $showingEndQuestionsAlert) {
            Button("Go back to settings", action: resetGame)
        } message: {
            Text("Your total score is \(score). \(questionsAnsweredWrong == 0 ? "" : messageIfQuestionsAnsweredWrong)")
        }
        .toolbar {
            Button("Next", action: nextQuestion)
                .font(.title2)
        }
    }
    
    func checkUserAnswer(firstNumber: Int, secondNumber: Int, answer: String) {
        if firstNumber * secondNumber == Int(answer) {
            score += 1
        } else {
            questionsAnsweredWrong += 1
            messageIfQuestionsAnsweredWrong = "You answered \(questionsAnsweredWrong) question\(questionsAnsweredWrong == 1 ? "" : "s") wrong!"
        }
        
        userAnswer = ""
    }
    
    func resetGame() {
        score = 0
        questionsAnsweredWrong = 0
        currentQuestionIndex = 1
        
        settingsCompleted = false
    }
    
    func nextQuestion() {
        userAnswer = userAnswer.trimmingCharacters(in: .whitespaces)
        guard userAnswer != "" else { return }
        
        checkUserAnswer(firstNumber: multiplicationTable, secondNumber: currentQuestionIndex, answer: userAnswer)
        
        if currentQuestionIndex < numberOfQuestions {
            currentQuestionIndex += 1
        } else {
            showingEndQuestionsAlert = true
        }
    }
}

struct SettingsView: View {
    @Binding var multiplicationTable: Int
    @Binding var numberOfQuestions: Int
    @Binding var settingsCompleted: Bool
    
    let possibleNumberOfQuestions = [5, 10, 20]
    
    var body: some View {
        NavigationView {
            Form {
                VStack(alignment: .leading) {
                    Text("Select a multiplication table to practice")
                        .font(.headline)
                    Stepper("Table of \(multiplicationTable)", value: $multiplicationTable, in: 2...12)
                }
                
                VStack(alignment: .leading) {
                    Text("Select how many questions do you want to be asked")
                        .font(.headline)
                    
                    Picker("Number of questions", selection: $numberOfQuestions) {
                        ForEach(possibleNumberOfQuestions, id: \.self) {
                            Text($0, format: .number)
                        }
                    }
                }
                
                Button {
                    settingsCompleted = true
                } label: {
                    Text("Practice")
                }
            }
            .navigationTitle("Configuration")
        }
    }
}

struct ContentView: View {
    @State private var multiplicationTable = 2
    @State private var numberOfQuestions = 5
    @State private var settingsCompleted = false
        
    var body: some View {
        NavigationView {
            VStack {
                if settingsCompleted {
                    GameView(multiplicationTable: multiplicationTable, numberOfQuestions: numberOfQuestions, settingsCompleted: $settingsCompleted)
                } else {
                    SettingsView(multiplicationTable: $multiplicationTable, numberOfQuestions: $numberOfQuestions, settingsCompleted: $settingsCompleted)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
