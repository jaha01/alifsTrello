//
//  ForgotPasswordPresenter.swift
//  alifsTrello
//
//  Created by Jahongir Anvarov on 26.09.2024.
//

import UIKit

protocol ForgotPasswordPresenterProtocol {
    func showError(config: AlertConfig)
    func showPasswordResetInfo(title: String, message: String)
}

final class ForgotPasswordPresenter: ForgotPasswordPresenterProtocol {
    
    weak var viewController: ForgotPasswordViewControllerProtocol!
    
    func showError(config: AlertConfig) {
        viewController.showErrorAlert(config: config)
    }
    
    func showPasswordResetInfo(title: String, message: String) {
        viewController.showSuccessAlert(config: AlertConfig(title: title, message: message))
    }
}
