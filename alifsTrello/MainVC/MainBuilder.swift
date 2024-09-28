//
//  MainBuilder.swift
//  alifsTrello
//
//  Created by Jahongir Anvarov on 27.09.2024.
//

import UIKit

final class MainBuilder {
    
    func build() -> UIViewController {
        let controller = MainViewController()
        let interactor = MainInteractor(authService: DI.shared.authService, dbService: DI.shared.dbService())
        let presenter = MainPresenter()
        let router = MainRouter()
        
        controller.interactor = interactor
        interactor.presenter = presenter
        interactor.router = router
        router.viewController = controller
        
        let navigationController = UINavigationController(rootViewController: controller)
        presenter.viewController = controller
        
        return navigationController
    }
    
}
