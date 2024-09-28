//
//  ForgotPasswordViewController.swift
//  alifsTrello
//
//  Created by Jahongir Anvarov on 26.09.2024.
//

import UIKit

protocol ForgotPasswordViewControllerProtocol: AnyObject {
    func showErrorAlert(config: AlertConfig)
    func showSuccessAlert(config: AlertConfig)
}

final class ForgotPasswordViewController: UIViewController, ForgotPasswordViewControllerProtocol {
    
    var interactor: ForgotPasswordInteractorProtocol!
    
    //MARK: - Properties
    private let headerView = AuthHeaderView(title: "Забыли пароль", subTitle: "Сбросить пароль")
    private let credentialsField = AuthTextField(fieldType: .credentials)
    private let resetPasswordButton = AuthButton(title: "Сброс", hasBackground: true, fontSize: .big)
    
    // MARK: - Public methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(headerView)
        view.addSubview(credentialsField)
        view.addSubview(resetPasswordButton)
        
        setupConstraints()
        resetPasswordButton.addTarget(self, action: #selector(didTapForgotPass), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    func showErrorAlert(config: AlertConfig) {
        AlertManager.showAlert(config: config)
    }
    
    func showSuccessAlert(config: AlertConfig) {
        AlertManager.showAlert(config: config, completion: {
            self.interactor.didTapLogin()
        })
    }
    
    // MARK: - Private methods
    @objc private func didTapForgotPass(){
        guard let email = self.credentialsField.text  else { return }
        
        if !Validator.isValidEmail(for: email) {
            credentialsField.animateError()
            return
        }
        
        interactor.resetPassword(email: email)
    }
    
    private func setupConstraints() {
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        credentialsField.translatesAutoresizingMaskIntoConstraints = false
        resetPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 230),
            
            credentialsField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 11),
            credentialsField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            credentialsField.heightAnchor.constraint(equalToConstant: 55),
            credentialsField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            credentialsField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            resetPasswordButton.topAnchor.constraint(equalTo: credentialsField.bottomAnchor, constant: 22),
            resetPasswordButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            resetPasswordButton.heightAnchor.constraint(equalToConstant: 55),
            resetPasswordButton.leadingAnchor.constraint(equalTo: credentialsField.leadingAnchor),
            resetPasswordButton.trailingAnchor.constraint(equalTo: credentialsField.trailingAnchor),
        ])
        
    }
    
}
