//
//  ContentView.swift
//  C4-ISocial
//
//  Created by Gabriel on 05/06/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        NSSortDescriptor(key: "isActive", ascending: false)
    ]) var users: FetchedResults<CachedUser>
    
    @State private var showingUsersRequestWarningAlert = false
    @StateObject private var viewModel = UserViewModel()
    
    var body: some View {
        NavigationView {
            List(users) { user in
                NavigationLink {
                    UserDetailView(user: user)
                } label: {
                    VStack(alignment: .leading) {
                        Text(user.wrappedName)
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
                await saveUsersToCoreData(users: viewModel.users)
            } catch {
                showingUsersRequestWarningAlert = true
            }
        }
        .alert("Sorry", isPresented: $showingUsersRequestWarningAlert) {
            Button("Ok") {}
        } message: {
            Text("There was a problem loading the current user list, please try again later.")
        }
    }
    
    func saveUsersToCoreData(users: [User]) async {
        await MainActor.run {
            var cachedUsers = [CachedUser(context: moc)]
            var cachedFriends = [CachedFriend(context: moc)]
            
            for user in users {
                let userTags = user.tags.joined(separator: ",")
                
                let newUser = CachedUser(context: moc)
                newUser.id = user.id
                newUser.isActive = user.isActive
                newUser.name = user.name
                newUser.age = Int16(user.age)
                newUser.company = user.company
                newUser.email = user.email
                newUser.address = user.address
                newUser.about = user.about
                newUser.registered = user.registered
                newUser.tags = userTags
                
                for friend in user.friends {
                    let newFriend = CachedFriend(context: moc)
                    newFriend.id = friend.id
                    newFriend.name = friend.name
                    
                    cachedFriends.append(newFriend)
                    newUser.addToFriends(newFriend)
                }
                
                cachedUsers.append(newUser)
            }
            
            try? moc.save()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
