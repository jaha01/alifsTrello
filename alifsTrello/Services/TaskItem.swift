//
//  TaskItem.swift
//  alifsTrello
//
//  Created by Jahongir Anvarov on 28.09.2024.
//

import Foundation

struct TaskItem {
    var id: String
    var title: String
    var description: String
    var assignee: String? // Имя исполнителя
    var dueDate: String? // Срок выполнения
    var status: String? // Текущий статус
    var comments: [String] // Комментарии к задаче
    
    init(dictionary: [String: Any]) {
        self.id = dictionary["id"] as? String ?? UUID().uuidString // Генерируем новый ID, если он отсутствует
        self.title = dictionary["title"] as? String ?? ""
        self.description = dictionary["description"] as? String ?? ""
        self.assignee = dictionary["assignee"] as? String
        self.dueDate = dictionary["dueDate"] as? String
        
        // Инициализация status (например, по умолчанию)
        if let statusString = dictionary["status"] as? String, let status = TaskStatus(rawValue: statusString) {
            self.status = statusString
//        } else {
//            self.status = .notSet.rawValue
        }
        
        // Инициализация comments
        self.comments = dictionary["comments"] as? [String] ?? []
    }
}
