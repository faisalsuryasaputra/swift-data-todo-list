//
//  modelContainer.swift
//  ToDoList
//
//  Created by DTC-02 on 08/01/26.
//

import SwiftUI
import SwiftData

@main
struct ModernTodoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: TodoItem.self) // Penting! Inisialisasi Database
    }
}
