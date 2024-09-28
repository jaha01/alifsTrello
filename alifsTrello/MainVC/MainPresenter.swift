//
//  MainPresenter.swift
//  alifsTrello
//
//  Created by Jahongir Anvarov on 27.09.2024.
//

import Foundation

protocol MainPresenterProtocol: AnyObject {
    func showError(config: AlertConfig)
    func prepareToShowTasksData(_ items: [TaskItem])
}

final class MainPresenter: MainPresenterProtocol {
    
    // MARK: - Public properties
    
    weak var viewController: MainViewControllerProtocol!
    
    // MARK: - Public methods
    
    func showError(config: AlertConfig) {
        viewController.showErrorAlert(config: config)
    }
    
    func prepareToShowTasksData(_ items: [TaskItem]) {
        viewController.showTasks(items)
    }
    
}
