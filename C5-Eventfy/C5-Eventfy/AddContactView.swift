//
//  AddContactView.swift
//  C5-Eventfy
//
//  Created by Gabriel on 15/06/23.
//

import SwiftUI

struct AddContactView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var image: Image?
    
    @StateObject private var viewModel = ViewModel()
    
    let onSave: (Contact) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section("Photo") {
                    ZStack {
                        if image != nil {
                            image?
                                .resizable()
                                .scaledToFit()
                        } else {
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.gray, style: StrokeStyle(lineWidth: 1, lineCap: CGLineCap.round, dash: [5, 5]))
                                .scaledToFit()
                            
                            Text("Picture")
                                .font(.headline)
                                .foregroundColor(.secondary.opacity(0.6))
                        }
                    }
                    
                    HStack {
                        Button("Select an image") {
                            viewModel.showingImagePicker = true
                        }
                        .foregroundColor(.blue)
                        Spacer()
                    }
                }
                
                Section("Name") {
                    TextField("Name", text: $viewModel.name)
                }
            }
            .navigationTitle("Add a contact")
            .sheet(isPresented: $viewModel.showingImagePicker) {
                ImagePicker(image: $viewModel.inputImage)
            }
            .onChange(of: viewModel.inputImage) { _ in loadImage() }
            .onAppear { viewModel.locationFetcher.start() }
            .toolbar {
                Button("Save") {
                    if let newContact = viewModel.createContact() {
                        onSave(newContact)
                        dismiss()
                    }
                }
            }
            .alert("We can't save your contact", isPresented: $viewModel.showingEmptyFieldError) {
                Button("Ok") { }
            } message: {
                Text("Please fill in all fields")
            }
        }
    }
    
    func loadImage() {
        guard let inputImage = viewModel.inputImage else { return }
        image = Image(uiImage: inputImage)
    }
}

struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        AddContactView { _ in }
    }
}
