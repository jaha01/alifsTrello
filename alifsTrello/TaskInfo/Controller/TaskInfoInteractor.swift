//
//  TaskInfoInteractor.swift
//  alifsTrello
//
//  Created by Jahongir Anvarov on 27.09.2024.
//

import Foundation

protocol TaskInfoInteractorProtocol: AnyObject {
    func getUsers()
}


final class TaskInfoInteractor: TaskInfoInteractorProtocol {
    
    // MARK: - Public properties
    
    var presenter: TaskInfoPresenterProtocol!
    var usersArray: [String] = []
    
    private let dbService: TasksItemServiceProtocol
    
    init(dbService: TasksItemServiceProtocol) {
        self.dbService = dbService
    }
    
    // MARK: - Public methods
    
    
    func getUsers() {
        dbService.fetchUsers { [weak self] users in
            guard let self = self else { return }

            for (uid, userData) in users {
                if let username = userData["username"] as? String {
                    self.usersArray.append(username)
                } else {
                    print("Username not found for user ID: \(uid)")
                }
            }

            self.presenter.getUsers(users: self.usersArray)
        }
    }
    
}
