//
//  MainInteractor.swift
//  alifsTrello
//
//  Created by Jahongir Anvarov on 27.09.2024.
//

import Foundation

protocol MainInteractorProtocol: AnyObject {
    func didTapSignOut()
    func onViewDidLoad()
    func appendItem(item: TaskItem)
    func deleteItem(id: String)
    func goToTaskInfo(item: TaskItem)
    func updateTaskItem(item: TaskItem) 
}

final class MainInteractor: MainInteractorProtocol {
    
    // MARK: - Public properties
    
    var presenter: MainPresenterProtocol!
    var router: MainRouterProtocol!
    
    // MARK: - Private properties
    
    private var items = [TaskItem]()
    private let authService: AuthServiceProtocol
    private let dbService: TasksItemServiceProtocol
    
    // MARK: - Initializer
    
    init(authService: AuthServiceProtocol,
         dbService: TasksItemServiceProtocol) {
        self.authService = authService
        self.dbService = dbService
    }
    
    // MARK: - Public methods
    
    func didTapSignOut() {
        
        authService.signOut { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                self.presenter.showError(config: AlertConfig(title: "Unknown Signin in Error", message: "\(error.localizedDescription)"))
                return
            }
            self.router.goToLogin()
        }
    }
    
    func onViewDidLoad() {
        dbService.setupTaskListener(handler: { [weak self] items in
            guard let self = self else { return }
            self.items = items
            self.presenter.prepareToShowTasksData(self.items)
        })
    }
    
    func appendItem(item: TaskItem) {
        dbService.uploadTaskItem(item: item) { result in
              switch result {
              case .success:
                  // Обработка успешного добавления элемента
                  print("Task item uploaded successfully.")
                  // Здесь можно обновить UI или сделать что-то другое

              case .failure(let error):
                  // Обработка ошибки
                  print("Error uploading task item: \(error.localizedDescription)")
                  // Здесь можно показать сообщение об ошибке пользователю
              }
          }
    }
    
    func updateTaskItem(item: TaskItem) {
        dbService.updateTaskItem(item: item) { result in
            switch result {
            case .success:
                print("Task item updated successfully.")
            case .failure(let error):
                print("Error updating task item: \(error.localizedDescription)")
            }
        }
    }
    
    func deleteItem(id: String) {
        self.dbService.removeTaskItem(id: id)
    }
    
    func goToTaskInfo(item: TaskItem) {
        router.goToTaskInfo(item: item)
    }
}
