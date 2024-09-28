//
//  TaskStates.swift
//  alifsTrello
//
//  Created by Jahongir Anvarov on 28.09.2024.
//


enum TaskStatus: String, CaseIterable {
    case new = "Новая"
    case inProgress = "В процессе"
    case completed = "Завершена"
    case closed = "Закрыта"
    case notSet = "Нет статуса"
    
    static func count() -> Int {
            return TaskStatus.allCases.count
        }
}
