//
//  MainRouter.swift
//  alifsTrello
//
//  Created by Jahongir Anvarov on 27.09.2024.
//

import UIKit

protocol MainRouterProtocol: AnyObject {
    func goToLogin()
    func goToTaskInfo(item: TaskItem)
}

final class MainRouter: MainRouterProtocol {
    
    // MARK: - Public properties
    
    weak var viewController: UIViewController!
    
    // MARK: - Public methods
    
    func goToLogin() {
        let login: UIViewController = LoginBuilder().build()
        let window = viewController.view.window
        window?.rootViewController = login
    }
    
    func goToTaskInfo(item: TaskItem) {
        guard let mainViewController = viewController as? MainViewController else { return }
        let taskInfo: UIViewController = TaskInfoBuilder().build(item: item, delegate: mainViewController)
        viewController.navigationController?.pushViewController(taskInfo, animated: true)
    }
    
}
