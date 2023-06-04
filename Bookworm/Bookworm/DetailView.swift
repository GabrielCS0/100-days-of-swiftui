//
//  DetailView.swift
//  Bookworm
//
//  Created by Gabriel on 03/06/23.
//

import SwiftUI

struct DetailView: View {
    let book: Book
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var showingDeleteAlert = false
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre ?? "Fantasy")
                    .resizable()
                    .scaledToFit()
                
                HStack {
                    Text(book.date?.formatted(date: .abbreviated, time: .omitted) ?? "N/A")
                        .font(.caption2)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                        .background(.black.opacity(0.9))
                        .padding(6)
                        .offset(y: 5)
                    
                    Spacer()
                    
                    Text(book.genre?.uppercased() ?? "FANTASY")
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(.black.opacity(0.75))
                        .clipShape(Capsule())
                        .offset(x: -5, y: -5)
                }
            }
            
            Text(book.author ?? "Unknown author")
                .font(.title)
                .foregroundColor(.secondary)
                .padding(.bottom)
            
            if book.review?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false {
                Text(book.review ?? "No review")
                    .padding(.bottom)
            }
            
            RatingView(rating: .constant(Int(book.rating)))
                .font(.largeTitle)
        }
        .navigationTitle(book.title ?? "Unknown book")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete Book?", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            Button {
                showingDeleteAlert = true
            } label: {
                Label("Delete this book", systemImage: "trash")
            }
        }
    }
    
    func deleteBook() {
        moc.delete(book)
        
        try? moc.save()
        dismiss()
    }
}
