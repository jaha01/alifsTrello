//
//  LoginBuilder.swift
//  alifsTrello
//
//  Created by Jahongir Anvarov on 26.09.2024.
//

import UIKit

final class LoginBuilder {
    func build() -> UIViewController {
        let controller = LoginViewController()
        let interactor = LoginInteractor(authService: DI.shared.authService)
        let presenter = LoginPresenter()
        let router = LoginRouter()
        
        controller.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = controller
        router.viewController = controller
        interactor.router = router
        
        return controller
    }
}
