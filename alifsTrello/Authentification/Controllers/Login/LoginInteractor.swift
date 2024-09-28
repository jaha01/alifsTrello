//
//  LoginInteractor.swift
//  alifsTrello
//
//  Created by Jahongir Anvarov on 26.09.2024.
//

import Foundation

protocol LoginInteractorProtocol {
    func signIn(loginRequest: LoginUserCredentials)
    func didTapRegistration()
    func didTapForgotPassword()
}

final class LoginInteractor: LoginInteractorProtocol {
    
    var router: LoginRouterProtocol!
    var presenter: LoginPresenterProtocol!
    
    private let authService: AuthServiceProtocol
    
    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }
    
    func signIn(loginRequest: LoginUserCredentials) {
        authService.signIn(with: loginRequest) { [weak self] error in
            
            guard let self = self else { return }
            
            if let error = error {
                self.presenter.showError(config: AlertConfig(title: "Sign in Error", message: "\(error.localizedDescription)"))
                return
            }
            
            self.router.goToMain()
            
        }
    }
    
    func didTapRegistration() {
        router.goToRegistration()
    }
    
    func didTapForgotPassword() {
        router.goToForgotPassword()
    }
}
