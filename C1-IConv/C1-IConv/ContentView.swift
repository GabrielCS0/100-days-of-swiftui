//
//  ContentView.swift
//  C1-IConv
//
//  Created by Gabriel on 11/04/23.
//

import SwiftUI

struct ContentView: View {
    @State private var thermometricScaleInput = "Celsius"
    @State private var thermometricScaleOutput = "Celsius"
    @State private var value = ""
    @FocusState private var inputIsFocused: Bool
    let thermometricScales = ["Celsius", "Fahrenheit", "Kelvin"]
    
    var result: Double {
        if value.isEmpty { return 0 }
        
        var celsiusValue: Double
        
        switch thermometricScaleInput {
        case "Fahrenheit":
            celsiusValue = (Double(value)! - 32) / 1.8
        case "Kelvin":
            celsiusValue = Double(value)! - 273.15
        default:
            celsiusValue = Double(value)!
        }
        
        switch thermometricScaleOutput {
        case "Fahrenheit":
            return (celsiusValue * 1.8) + 32
        case "Kelvin":
            return celsiusValue + 273.15
        default:
            return celsiusValue
        }
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                
                Picker("Convert from", selection: $thermometricScaleInput) {
                    ForEach(thermometricScales, id: \.self) { item in
                        Text(item)
                    }
                }
                
                Picker("To", selection: $thermometricScaleOutput) {
                    ForEach(thermometricScales, id: \.self) { item in
                        Text(item)
                    }
                }
                
                TextField("Enter a value to convert", text: $value)
                    .keyboardType(.decimalPad)
                    .focused($inputIsFocused)
                
                Text("Result: \(result.formatted())")
            }
            .navigationTitle("IConv")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        inputIsFocused = false
                    }
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
