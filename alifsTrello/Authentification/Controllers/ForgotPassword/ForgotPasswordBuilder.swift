//
//  ForgotPasswordBuilder.swift
//  alifsTrello
//
//  Created by Jahongir Anvarov on 26.09.2024.
//

import UIKit

final class ForgotPasswordBuilder {
    func build() -> UIViewController {
        let controller = ForgotPasswordViewController()
        let interactor = ForgotPasswordInteractor(authService: DI.shared.authService)
        let presenter = ForgotPasswordPresenter()
        let router = ForgotPasswordRouter()

        controller.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = controller
        router.viewController = controller
        interactor.router = router
        
        return controller
    }
}
