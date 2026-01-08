//
//  ContentView.swift
//  ToDoList
//
//  Created by DTC-02 on 08/01/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    // Diurutkan berdasarkan Due Date (yang paling dekat paling atas)
    @Query(sort: \TodoItem.dueDate, order: .forward) private var items: [TodoItem]
    
    @State private var showAddSheet = false

    var body: some View {
        NavigationStack {
            List {
                if items.isEmpty {
                    ContentUnavailableView(
                        "Semua Beres!",
                        systemImage: "checkmark.seal",
                        description: Text("Tidak ada tugas. Tekan + untuk buat baru.")
                    )
                } else {
                    ForEach(items) { item in
                        TodoRowView(item: item)
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    deleteItem(item)
                                } label: {
                                    Label("Hapus", systemImage: "trash")
                                }
                            }
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("To-Do List")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: { showAddSheet = true }) {
                        Image(systemName: "plus")
                            .fontWeight(.bold)
                    }
                }
            }
            // Ganti Alert dengan Sheet (Halaman Modal)
            .sheet(isPresented: $showAddSheet) {
                AddItemView()
            }
        }
    }

    private func deleteItem(_ item: TodoItem) {
        withAnimation {
            modelContext.delete(item)
        }
    }
}
