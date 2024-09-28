//
//  RegistrationPresenter.swift
//  alifsTrello
//
//  Created by Jahongir Anvarov on 26.09.2024.
//

import UIKit

protocol RegistrationPresenterProtocol {
    func showError(config: AlertConfig)
}

final class RegistrationPresenter: RegistrationPresenterProtocol {
    
    weak var viewController: RegistrationViewControllerProtocol!
    
    func showError(config: AlertConfig) {
        viewController.showErrorAlert(config: config)
    }

}
