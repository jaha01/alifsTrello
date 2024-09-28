//
//  SMSCodeVerificationInteractor.swift
//  alifsTrello
//
//  Created by Jahongir Anvarov on 26.09.2024.
//

import Foundation

protocol SMSCodeVerificationInteractorProtocol {
    func verify(code: String?)
}

final class SMSCodeVerificationInteractor: SMSCodeVerificationInteractorProtocol {
    
    // MARK: - Public properties
    
    var router: SMSCodeVerificationRouterProtocol!
    var presenter: SMSCodeVerificationPresenterProtocol!
    var verificationId: String
    // MARK: - Private properties
    
    private let authService: AuthServiceProtocol
    
    // MARK: - Public methods
    
    init(authService: AuthService, verificationId: String) {
        self.authService = authService
        self.verificationId = verificationId
    }
    
    func verify(code: String?) {
        guard let code = code else { return }
        authService.verifyCode(verificationId: verificationId, smsCode: code) { [weak self] error in
            guard let self = self else {return}
            if let error = error {
                self.presenter.showCodeVerifyError(title: "Error verifying code", message: error.localizedDescription)
            }
            self.router.goToMain()
        }
    }
}
