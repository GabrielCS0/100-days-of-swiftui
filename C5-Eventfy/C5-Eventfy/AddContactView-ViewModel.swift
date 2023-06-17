//
//  AddContactView-ViewModel.swift
//  C5-Eventfy
//
//  Created by Gabriel on 16/06/23.
//

import Foundation
import SwiftUI

extension AddContactView {
    @MainActor class ViewModel: ObservableObject {
        @Published var name = ""
        @Published var inputImage: UIImage?
        
        @Published var showingImagePicker = false
        @Published var showingEmptyFieldError = false
                
        func createContact() -> Contact? {
            guard let inputImage = inputImage else {
                showingEmptyFieldError = true
                return nil
            }
            
            if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                showingEmptyFieldError = true
                return nil
            }
            
            let contact = Contact(name: name, picture: inputImage)
            return contact
        }
    }
}
