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
        
        let locationFetcher = LocationFetcher()
                
        func createContact() -> Contact? {
            guard let inputImage = inputImage else {
                showingEmptyFieldError = true
                return nil
            }
            
            if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                showingEmptyFieldError = true
                return nil
            }
            
            let eventLocation = Coordinate(locationFetcher.lastKnownLocation)
            let contact = Contact(name: name, picture: inputImage, eventLocation: eventLocation)
            
            return contact
        }
    }
}
