//
//  Task.swift
//  alifsTrello
//
//  Created by Jahongir Anvarov on 28.09.2024.
//

import Foundation

struct Task {
    var id: UUID
    var title: String
    var description: String
    var assignee: String? // Имя исполнителя
    var dueDate: Date? // Срок выполнения
    var status: TaskStatus // Текущий статус
    var comments: [String] // Комментарии к задаче
}
