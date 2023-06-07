//
//  ContentView.swift
//  C4-ISocial
//
//  Created by Gabriel on 05/06/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = UserViewModel()
    @State private var showingFetchUsersErrorAlert = false
    
    var body: some View {
        NavigationView {
            List(viewModel.users) { user in
                NavigationLink {
                    UserDetailView(user: user)
                } label: {
                    VStack(alignment: .leading) {
                        Text(user.name)
                            .padding(.bottom, 0.5)
                        
                        Text(user.isActive ? "Online" : "Offline")
                            .foregroundColor(user.isActive ? .green : .red)
                            .font(.footnote)
                            .fontWeight(.bold)
                    }
                }
            }
            .navigationTitle("ISocial")
        }
        .task {
            do {
                try await viewModel.fetchUsers()
            } catch {
                showingFetchUsersErrorAlert = true
            }
        }
        .alert("Sorry", isPresented: $showingFetchUsersErrorAlert) {
            Button("Ok") {}
        } message: {
            Text("There was an error loading users, please try again later.")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
