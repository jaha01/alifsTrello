//
//  RegistrationInteractor.swift
//  alifsTrello
//
//  Created by Jahongir Anvarov on 26.09.2024.
//

import UIKit

protocol RegistrationInteractorProtocol {
    func registerUser(registerUserCredentials: RegisterUserCredentials)
    func registerUserByPhone(registerUserCredentials: RegisterUserCredentials)
    func goToLogin()
}

final class RegistrationInteractor: RegistrationInteractorProtocol {
    
    var router: RegistrationRouterProtocol!
    var presenter: RegistrationPresenterProtocol!
    
    private let authService: AuthServiceProtocol
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func registerUser(registerUserCredentials: RegisterUserCredentials) {
        authService.registerUser(with: registerUserCredentials) { [weak self] error in
            
            guard let self = self else { return }
            
            if let error = error {
                self.presenter.showError(config: AlertConfig( title: "Unknown Registration Error", message: "\(error.localizedDescription)"))
                return
            }
            
            self.router.goToMain()
        }
    }
    
    func registerUserByPhone(registerUserCredentials: RegisterUserCredentials) {
        
        authService.registerByPhone(phoneNumber: registerUserCredentials.singInMeth) { [weak self] verificationId, error  in
            guard let verificationId = verificationId, let self = self else { return }
            if let error = error {
                self.presenter.showError(config: AlertConfig(title: "Error!", message: error.localizedDescription))
            }
            self.router.goToVerifyCode(verificationId: verificationId)
        }
    }
    
    func goToLogin() {
        self.router.goToLogin()
    }
}
