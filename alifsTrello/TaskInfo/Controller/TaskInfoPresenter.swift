//
//  TaskInfoPresenter.swift
//  alifsTrello
//
//  Created by Jahongir Anvarov on 27.09.2024.
//

import Foundation

protocol TaskInfoPresenterProtocol {
    func getUsers(users: [String])
}

final class TaskInfoPresenter: TaskInfoPresenterProtocol {
    
    // MARK: - Public properties
    private var usersArray = [String]()
    
    weak var viewController: TaskInfoViewControllerProtocol!
    
    // MARK: - Public
    
    func getUsers(users: [String]) {
        usersArray = users
        viewController.getUsers(users: users)
    }
    
//    func prepareTaskItem(item: TaskItem) {
//        viewController.getTaskItem(item: item)
//    }
    
}
