//
//  SMSCodeVerificationPresenter.swift
//  alifsTrello
//
//  Created by Jahongir Anvarov on 26.09.2024.
//

import Foundation

protocol SMSCodeVerificationPresenterProtocol {
    func showCodeVerifyError(title: String, message: String)
}

final class SMSCodeVerificationPresenter: SMSCodeVerificationPresenterProtocol {
    
    // MARK: - Public properties
    weak var viewController: SMSCodeVerificationViewControllerProtocol!
    
    // MARK: - Public func
    
    func showCodeVerifyError(title: String, message: String) {
        viewController.showErrorAlert(config: AlertConfig(title: title, message: message))
    }
}
