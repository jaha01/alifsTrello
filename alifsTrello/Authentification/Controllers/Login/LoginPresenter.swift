//
//  LoginPresenter.swift
//  alifsTrello
//
//  Created by Jahongir Anvarov on 26.09.2024.
//

import Foundation
import UIKit

protocol LoginPresenterProtocol {
    func showError(config: AlertConfig)
}

final class LoginPresenter: LoginPresenterProtocol {
    weak var viewController: LoginViewControllerProtocol!
    
    func showError(config: AlertConfig) {
        viewController.showErrorAlert(config: config)
    }
}
