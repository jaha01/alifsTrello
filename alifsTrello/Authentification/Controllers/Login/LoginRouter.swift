//
//  LoginRouter.swift
//  alifsTrello
//
//  Created by Jahongir Anvarov on 26.09.2024.
//

import UIKit

protocol LoginRouterProtocol {
    func goToMain()
    func goToRegistration()
    func goToForgotPassword()
}

final class LoginRouter: LoginRouterProtocol {
    weak var viewController: UIViewController!
    
    func goToMain(){
        let mainController: UIViewController = MainBuilder().build()
        let window = viewController.view.window
        window?.rootViewController = mainController
    }
    
    func goToRegistration() {
        let registration: UIViewController = RegistrationBuilder().build()
        let window = viewController.view.window
        window?.rootViewController = registration
    }
    
    func goToForgotPassword() {
        let forgotPassword: UIViewController = ForgotPasswordBuilder().build()
        let window = viewController.view.window
        window?.rootViewController = forgotPassword
    }
}
