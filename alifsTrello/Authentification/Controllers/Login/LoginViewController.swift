//
//  LoginViewController.swift
//  alifsTrello
//
//  Created by Jahongir Anvarov on 26.09.2024.
//

import Foundation
import UIKit

protocol LoginViewControllerProtocol: AnyObject {
    func showErrorAlert(config: AlertConfig)
}

final class LoginViewController: UIViewController, LoginViewControllerProtocol {

    var interactor: LoginInteractorProtocol!
    
    // MARK: - Private properties
    private let headerView = AuthHeaderView(title: "Вход", subTitle: "Войдите в ваш аккаунт")
    private let credentialsField = AuthTextField(fieldType: .credentials)
    private let passwordField = AuthTextField(fieldType: .password)
    
    private let signInButton = AuthButton(title: "Войти", hasBackground: true, fontSize: .big)
    private let newUserButton = AuthButton(title: "Новый юзер? Создайте аккаунт", fontSize: .med)
    private let forgotPasswordButton = AuthButton(title: "Забыли пароль?", fontSize: .small)
    
    
    // MARK: - Public methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(headerView)
        view.addSubview(credentialsField)
        view.addSubview(passwordField)
        view.addSubview(signInButton)
        view.addSubview(newUserButton)
        view.addSubview(forgotPasswordButton)
        setupConstraints()
        
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        newUserButton.addTarget(self, action: #selector(didTapNewUser), for: .touchUpInside)
        forgotPasswordButton.addTarget(self, action: #selector(didTapForgotPass), for: .touchUpInside)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    func showErrorAlert(config: AlertConfig) {
        AlertManager.showAlert(config: config)
    }
    
    // MARK: Private methods
    
    @objc private func didTapSignIn() {

        let loginRequest = LoginUserCredentials(email: self.credentialsField.text ?? "",
                                            password: self.passwordField.text ?? "")
        
        if !Validator.isValidEmail(for: loginRequest.email) {
            credentialsField.animateError()
        }
        
        if !Validator.isPasswordValid(for: loginRequest.password) {
            passwordField.animateError()
            return
        }

        interactor.signIn(loginRequest: loginRequest)
    }

    @objc private func didTapNewUser() {
        interactor.didTapRegistration()
    }
    
    @objc private func didTapForgotPass() {
        interactor.didTapForgotPassword()
    }
    
    private func setupConstraints() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        credentialsField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        newUserButton.translatesAutoresizingMaskIntoConstraints = false
        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 222),
            
            credentialsField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 12),
            credentialsField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            credentialsField.heightAnchor.constraint(equalToConstant: 55),
            credentialsField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            credentialsField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            passwordField.topAnchor.constraint(equalTo: credentialsField.bottomAnchor, constant: 22),
            passwordField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            passwordField.heightAnchor.constraint(equalToConstant: 55),
            passwordField.leadingAnchor.constraint(equalTo: credentialsField.leadingAnchor),
            passwordField.trailingAnchor.constraint(equalTo: credentialsField.trailingAnchor),
            
            signInButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 22),
            signInButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            signInButton.heightAnchor.constraint(equalToConstant: 55),
            signInButton.leadingAnchor.constraint(equalTo: credentialsField.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: credentialsField.trailingAnchor),
            
            newUserButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 11),
            newUserButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            newUserButton.heightAnchor.constraint(equalToConstant: 44),
            newUserButton.leadingAnchor.constraint(equalTo: credentialsField.leadingAnchor),
            newUserButton.trailingAnchor.constraint(equalTo: credentialsField.trailingAnchor),
            
            forgotPasswordButton.topAnchor.constraint(equalTo: newUserButton.bottomAnchor, constant: 6),
            forgotPasswordButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            forgotPasswordButton.heightAnchor.constraint(equalToConstant: 44),
            forgotPasswordButton.leadingAnchor.constraint(equalTo: credentialsField.leadingAnchor),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: credentialsField.trailingAnchor)
        ])
    }
}


