//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Gabriel on 28/06/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var favorites = Favorites()
    @StateObject private var resortsSortType = ResortsSortType()
    
    @State private var searchText = ""
    @State private var showingSortDialog = false
    
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    var sortedResorts: [Resort] {
        if resortsSortType.type == "alphabetical" {
            return resorts.sorted()
        } else if resortsSortType.type == "country" {
            return resorts.sorted { $0.country < $1.country }
        }
        
        return resorts
    }
    
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            return sortedResorts
        } else {
            return sortedResorts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationView {
            List(filteredResorts) { resort in
                NavigationLink {
                    ResortView(resort: resort)
                } label: {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 25)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundColor(.secondary)
                        }
                        
                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite resort")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .searchable(text: $searchText, prompt: "Search for a resort")
            .toolbar {
                Button {
                    showingSortDialog = true
                } label: {
                    Label("Sort", systemImage: "shuffle.circle")
                }
            }
            .confirmationDialog("Sort", isPresented: $showingSortDialog) {
                Button("Sort by default") { resortsSortType.type = "default" }
                Button("Sort by name") { resortsSortType.type = "alphabetical" }
                Button("Sort by country") { resortsSortType.type = "country" }
            }

            WelcomeView()
        }
        .environmentObject(favorites)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
