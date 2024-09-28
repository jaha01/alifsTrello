//
//  SMSCodeVerificationRouter.swift
//  alifsTrello
//
//  Created by Jahongir Anvarov on 26.09.2024.
//

import UIKit

protocol SMSCodeVerificationRouterProtocol {
    func goToMain()
}

final class SMSCodeVerificationRouter: SMSCodeVerificationRouterProtocol {
    weak var viewController: UIViewController!
    
    func goToMain() {
        let mainController: UIViewController = MainBuilder().build()
        let window = viewController.view.window
        window?.rootViewController = mainController
    }
}
