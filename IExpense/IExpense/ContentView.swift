//
//  ContentView.swift
//  IExpense
//
//  Created by Gabriel on 22/05/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    let userCurrencyCode = Locale.current.currency?.identifier ?? "USD"
    
    var body: some View {
        NavigationView {
            Form {
                List {
                    ForEach(expenses.items) {
                        ListExpense(expense: $0, userCurrencyCode: userCurrencyCode, amountTextColor: amountTextColor($0.amount))
                    }
                    .onDelete(perform: removeItems)
                }
            }
            .navigationTitle("IExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses, userCurrencyCode: userCurrencyCode)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
    func amountTextColor(_ amount: Double) -> Color {
        var textColor: Color
        
        if amount <= 10 {
            textColor = Color.green
        } else if amount <= 100 {
            textColor = Color.yellow
        } else {
            textColor = Color.red
        }
        
        return textColor
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
