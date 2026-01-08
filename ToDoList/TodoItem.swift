//
//  TodoItem.swift
//  ToDoList
//
//  Created by DTC-02 on 08/01/26.
//

import Foundation
import SwiftData

@Model
class TodoItem {
    var title: String
    var isCompleted: Bool
    var createdAt: Date
    var dueDate: Date // <--- Properti Baru
    
    init(title: String, isCompleted: Bool = false, dueDate: Date = Date()) {
        self.title = title
        self.isCompleted = isCompleted
        self.createdAt = Date()
        self.dueDate = dueDate
    }
}
