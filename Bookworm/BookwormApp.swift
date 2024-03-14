//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Monty Harper on 3/8/24.
//

import SwiftData
import SwiftUI

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
