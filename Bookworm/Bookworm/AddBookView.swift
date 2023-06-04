//
//  AddBookView.swift
//  Bookworm
//
//  Created by Gabriel on 02/06/23.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasy"
    @State private var review = ""
    
    @State private var showingMissingTitleAlert = false
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                } header: {
                    Text("Write a review")
                }
                
                Section {
                    Button("Save", action: saveBook)
                }
            }
            .navigationTitle("Add Book")
        }
        .alert("Missing book's title", isPresented: $showingMissingTitleAlert) {
            Button("Ok") { }
        } message: {
            Text("You must provide the name of the book!")
        }
    }
    
    func saveBook() {
        if title.trimmingCharacters(in: .whitespaces).isEmpty {
            showingMissingTitleAlert = true
            return
        }
        
        if author.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            author = "Unknown author"
        }
        
        let newBook = Book(context: moc)
        newBook.id = UUID()
        newBook.title = title
        newBook.author = author
        newBook.rating = Int16(rating)
        newBook.genre = genre
        newBook.review = review
        newBook.date = Date.now

        try? moc.save()
        
        dismiss()
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
