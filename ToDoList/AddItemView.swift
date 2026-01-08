//
//  AddItemView.swift
//  ToDoList
//
//  Created by DTC-02 on 08/01/26.
//

import SwiftUI
import SwiftData

struct AddItemView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss // Untuk menutup sheet
    
    @State private var title = ""
    @State private var dueDate = Date()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Mau ngerjain apa?", text: $title)
                        .font(.headline)
                } header: {
                    Text("Nama Tugas")
                }
                
                Section {
                    DatePicker("Pilih Tanggal", selection: $dueDate, displayedComponents: [.date, .hourAndMinute])
                        .datePickerStyle(.graphical) // Tampilan kalender modern
                } header: {
                    Text("Tenggat Waktu (Due Date)")
                }
            }
            .navigationTitle("Tugas Baru")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Batal") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Simpan") {
                        saveItem()
                    }
                    .disabled(title.isEmpty) // Tombol mati jika teks kosong
                }
            }
        }
    }
    
    private func saveItem() {
        let newItem = TodoItem(title: title, dueDate: dueDate)
        modelContext.insert(newItem)
        dismiss()
    }
}
