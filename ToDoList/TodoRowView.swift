//
//  TodoRowView.swift
//  ToDoList
//
//  Created by DTC-02 on 08/01/26.
//

import SwiftUI

struct TodoRowView: View {
    @Bindable var item: TodoItem
    
    // Format tanggal biar enak dibaca (Contoh: "Hari ini, 14:00" atau "Besok")
    private var formattedDate: String {
        item.dueDate.formatted(.dateTime.day().month().hour().minute())
    }
    
    // Cek apakah sudah lewat deadline?
    private var isOverdue: Bool {
        item.dueDate < Date() && !item.isCompleted
    }
    
    var body: some View {
        HStack(alignment: .top) { // Alignment top agar rapi jika teks panjang
            // Checkbox Interaktif
            Button(action: {
                toggleCompletion()
            }) {
                Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
                    .foregroundStyle(item.isCompleted ? .green : (isOverdue ? .red : .gray))
                    .contentTransition(.symbolEffect(.replace)) // Animasi icon ios 17+
            }
            .buttonStyle(.plain)
            .padding(.top, 4) // Sedikit turun biar sejajar teks
            
            VStack(alignment: .leading, spacing: 4) {
                // Judul Tugas
                Text(item.title)
                    .font(.body)
                    .fontWeight(.medium)
                    .strikethrough(item.isCompleted)
                    .foregroundStyle(item.isCompleted ? .secondary : .primary)
                
                // Info Tanggal
                HStack(spacing: 4) {
                    Image(systemName: "calendar")
                    Text(formattedDate)
                }
                .font(.caption)
                // Warna merah jika telat, abu-abu jika selesai/biasa
                .foregroundStyle(isOverdue ? .red : .secondary)
            }
            
            Spacer()
        }
        .padding(.vertical, 6)
        .opacity(item.isCompleted ? 0.6 : 1.0) // Redupkan jika selesai
    }
    
    private func toggleCompletion() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred() // Efek getar (Haptic)
        
        withAnimation(.snappy) {
            item.isCompleted.toggle()
        }
    }
}
