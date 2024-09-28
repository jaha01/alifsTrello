//
//  SMSCodeVerificationBuilder.swift
//  alifsTrello
//
//  Created by Jahongir Anvarov on 26.09.2024.
//

import Foundation
import UIKit

final class SMSCodeVerificationBuilder {
    
    func build(verificationId: String) -> UIViewController {

        let controller = SMSCodeVerificationViewController()
        let interactor = SMSCodeVerificationInteractor(authService: DI.shared.authService, verificationId: verificationId)
        let presenter = SMSCodeVerificationPresenter()
        let router =  SMSCodeVerificationRouter()
        
        controller.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = controller
        router.viewController = controller
        interactor.router = router
        
        return controller
    }
}

