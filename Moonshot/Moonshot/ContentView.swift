//
//  ContentView.swift
//  Moonshot
//
//  Created by Gabriel on 24/05/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showingGridLayout = true
    
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var body: some View {
        NavigationView {
            Group {
                if showingGridLayout {
                    GridLayout(missions: missions, astronauts: astronauts)
                } else {
                    ListLayout(missions: missions, astronauts: astronauts)
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                Button("Change view style") {
                    showingGridLayout.toggle()
                }
                .foregroundColor(.white.opacity(0.8))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
