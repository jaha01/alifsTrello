//
//  TaskInfoBuilder.swift
//  alifsTrello
//
//  Created by Jahongir Anvarov on 27.09.2024.
//

import UIKit

final class TaskInfoBuilder {
    func build(item: TaskItem, delegate: TaskInfoDelegate) -> UIViewController {
        let controller = TaskInfoViewController()
        let interactor = TaskInfoInteractor(dbService: DI.shared.dbService())
        let presenter = TaskInfoPresenter()
        
        controller.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = controller
        controller.item = item
        controller.delegate = delegate

        return controller
    }
    
}
