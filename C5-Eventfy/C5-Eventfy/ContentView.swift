//
//  ContentView.swift
//  C5-Eventfy
//
//  Created by Gabriel on 15/06/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    @State private var showingAddContactSheet = false
    
    var body: some View {
        NavigationView {
            List(viewModel.contacts) { contact in
                NavigationLink {
                    ContactDetailsView(contact: contact)
                } label: {
                    Image(uiImage: contact.picture)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 75)
                        .padding(.trailing)
                    
                    Text(contact.name)
                        .font(.headline)
                }
            }
            .navigationTitle("Eventfy")
            .toolbar {
                Button {
                    showingAddContactSheet = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddContactSheet) {
                AddContactView { newContact in
                    viewModel.saveContact(contact: newContact)
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
