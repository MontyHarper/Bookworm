//
//  DetailView.swift
//  Bookworm
//
//  Created by Monty Harper on 3/13/24.
//

import SwiftData
import SwiftUI

struct DetailView: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State var showingDeleteAlert = false
    
    var book: Book
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                getImage(book.genre)
                    .resizable()
                    .scaledToFit()
                
                Text(book.genre.uppercased())
                    .padding(3)
                    .fontWeight(.black)
                    .foregroundStyle(.white)
                    .background(.black.opacity(0.7))
                    .offset(x: -5, y: -5)
            }
            
            HStack {
                Text("by")
                Text(book.author)
                    .font(.title)
                    .foregroundStyle(.secondary)
            }
            .padding()
            VStack(alignment: .leading) {
                Text(book.date.formatted())
                    .font(.subheadline)
                    .fontWeight(.bold)
                Text(book.review)
            }
            RatingView(rating:.constant(book.rating))
                .font(.largeTitle)
                .padding()
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Delete This Book", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: {delete()})
            Button("Nevermind", role: .cancel, action: {})
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            Button("Delete This Book", systemImage: "trash") {
                showingDeleteAlert = true
            }
        }
        
    }
    
    func delete() {
        modelContext.delete(book)
        dismiss()
    }
    
    func getImage(_ name: String) -> Image {
        if UIImage(named: name) == nil {
            return Image("Fantasy") // would want to replace with a default image
        } else {
            return Image(name)
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Book.self, configurations: config)
        let example = Book(title: "Test Book", author: "Test Author", genre: "Fantasy", review: "This was a great book; I really enjoyed it.", rating: 4)

        return DetailView(book: example)
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
