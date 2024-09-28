//
//  ForgotPasswordRouter.swift
//  alifsTrello
//
//  Created by Jahongir Anvarov on 26.09.2024.
//

import UIKit

protocol ForgotPasswordRouterProtocol {
    func goToLogin()
}

final class ForgotPasswordRouter: ForgotPasswordRouterProtocol {
    weak var viewController: UIViewController!
    
    func goToLogin() {
        let mainController: UIViewController = LoginBuilder().build()
        let window = viewController.view.window
        window?.rootViewController = mainController
    }
}
