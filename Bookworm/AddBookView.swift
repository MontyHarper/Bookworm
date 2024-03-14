//
//  AddBookView.swift
//  Bookworm
//
//  Created by Monty Harper on 3/11/24.
//

import SwiftData
import SwiftUI

struct AddBookView: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var genre = ""
    @State private var review = ""
    @State private var rating = 3
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        
        NavigationStack {
            Form {
                Section {
                    TextField("Title*", text: $title)
                    TextField("Author*", text: $author)
                    
                    HStack {
                        TextField("Genre*", text: $genre)
                        
                        Picker("Genre", selection: $genre) {
                            ForEach(genres, id: \.self) {
                                Text($0)
                            }
                        }
                        .labelsHidden()
                    }
                }
                Section("Write a Review") {
                    TextEditor(text: $review)
                    
                    RatingView(rating: $rating)
                }
                
                Section {
                    Button("Save") {
                        let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating)
                        modelContext.insert(newBook)
                        dismiss()
                    }
                    .disabled(title.isEmpty || author.isEmpty || genre.isEmpty)
                }
            }
            .navigationTitle("Add Book")
        }
    }
}

#Preview {
    AddBookView()
}
