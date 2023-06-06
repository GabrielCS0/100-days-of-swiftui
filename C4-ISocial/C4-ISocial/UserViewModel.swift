//
//  UserViewModel.swift
//  C4-ISocial
//
//  Created by Gabriel on 05/06/23.
//

import Foundation

class UserViewModel: ObservableObject {
    @Published var users = [User]()
    
    func fetchUsers() async throws {
        guard users.isEmpty else {
            return
        }
                
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            return
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedUsers = try JSONDecoder().decode([User].self, from: data)
        
        DispatchQueue.main.async {
            self.users = decodedUsers
        }
    }
}
