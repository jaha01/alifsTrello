//
//  RegistrationRouter.swift
//  alifsTrello
//
//  Created by Jahongir Anvarov on 26.09.2024.
//

import UIKit

protocol RegistrationRouterProtocol {
    func goToMain()
    func goToVerifyCode(verificationId: String)
    func goToLogin()
}

final class RegistrationRouter: RegistrationRouterProtocol {
    
    // MARK: - Public properties
    
    weak var viewController: UIViewController!
    
    // MARK: - Public methods
    
    func goToMain() {
        let mainController: UIViewController = MainBuilder().build()
        let window = viewController.view.window
        window?.rootViewController = mainController
    }
    
    func goToVerifyCode(verificationId: String) {
        let smsVerificationVC = SMSCodeVerificationBuilder().build(verificationId: verificationId)
        let nav = UINavigationController(rootViewController: smsVerificationVC)
        nav.navigationBar.backgroundColor = .white
        viewController.present(nav, animated: true, completion: nil)
    }
    
    func goToLogin() {
        let mainController: UIViewController = LoginBuilder().build()
        let window = viewController.view.window
        window?.rootViewController = mainController
    }
    
}
