//
//  ContentView-ViewModel.swift
//  C5-Eventfy
//
//  Created by Gabriel on 15/06/23.
//

import Foundation

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published var showingAddContactSheet = false
        @Published var contacts = [Contact]()
        
        let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedContacts")
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                contacts = try JSONDecoder().decode([Contact].self, from: data)
                contacts = contacts.sorted()
            } catch {
                contacts = []
            }
        }
        
        func saveContact(contact: Contact) {
            contacts.append(contact)
            
            do {
                let data = try JSONEncoder().encode(contacts)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }
    }
}
