//
//  ContentView.swift
//  Bookworm
//
//  Created by Monty Harper on 3/8/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
    @Query(sort: [
        SortDescriptor(\Book.rating, order: .reverse),
        SortDescriptor(\Book.author),
        SortDescriptor(\Book.title)
    ]) private var books: [Book]
    
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(books) {book in
                    NavigationLink(value: book) {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            VStack(alignment: .leading) {
                                Text(book.title)
                                    .font(.headline)
                                    .foregroundStyle(book.rating > 1 ? .black : .red)
                                Text(book.author)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .navigationTitle("Bookworm")
            .navigationDestination(for: Book.self) { book in
                DetailView(book: book)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Book", systemImage: "plus") {
                        showingAddScreen = true
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                AddBookView()
            }
        }
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for index in offsets {
            let book = books[index]
            modelContext.delete(book)
        }
    }
}
    


#Preview {
    ContentView()
}
