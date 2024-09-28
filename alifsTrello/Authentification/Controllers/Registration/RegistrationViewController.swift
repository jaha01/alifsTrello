//
//  RegistrationViewController.swift
//  alifsTrello
//
//  Created by Jahongir Anvarov on 26.09.2024.
//

import UIKit

protocol RegistrationViewControllerProtocol: AnyObject {
    func showErrorAlert(config: AlertConfig)
}

final class RegistrationViewController: UIViewController, RegistrationViewControllerProtocol {
    
    var interactor: RegistrationInteractorProtocol!
    
    // MARK: - Private properties
    private let headerView = AuthHeaderView(title: "Регистрация", subTitle: "Создайте аккаунт")
    private let usernameField = AuthTextField(fieldType: .username)
    private let credentialsField = AuthTextField(fieldType: .credentials)
    private let passwordField = AuthTextField(fieldType: .password)
    
    private let signUpButton = AuthButton(title: "Регистрация", hasBackground: true, fontSize: .big)
    private let signInButton = AuthButton(title: "Уже есть аккаунт? Войдите", fontSize: .med)
    
    private let termsTextView: UITextView = {
        
        let attributedString = NSMutableAttributedString(string: "Вы соглашаетесь с нашими условиями и положениями и прочитали политику конфиденциальности.")
        attributedString.addAttribute(.link, value: "terms://terms&conditions", range: (attributedString.string as NSString).range(of: "terms & conditions"))
        attributedString.addAttribute(.link, value: "privacy://privacyPolicy", range: (attributedString.string as NSString).range(of: "privacy policy"))
        
        let tv = UITextView()
        tv.linkTextAttributes = [.foregroundColor: UIColor.systemBlue]
        tv.backgroundColor = .clear
        tv.attributedText = attributedString
        tv.textColor = .label
        tv.textAlignment = .center
        tv.isSelectable = true
        tv.isEditable = false
        tv.delaysContentTouches = false
        tv.isScrollEnabled = false
        return tv
    }()
    
    // MARK: - Public methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(headerView)
        view.addSubview(usernameField)
        view.addSubview(passwordField)
        view.addSubview(credentialsField)
        view.addSubview(signInButton)
        view.addSubview(signUpButton)
        view.addSubview(termsTextView)
        termsTextView.delegate = self
        
        setupConstraints()
        
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
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
        interactor.goToLogin()
    }
    
    @objc private func didTapSignUp() {
        let registerUserCredentials = RegisterUserCredentials(username: usernameField.text ?? "",
                                                              singInMeth: credentialsField.text ?? "",
                                                              password: passwordField.text ?? "")
        
        if !Validator.isValidUsername(for: registerUserCredentials.username) {
            usernameField.animateError()
            return
        }

        if !Validator.isPasswordValid(for: registerUserCredentials.password) {
            passwordField.animateError()
            return
        }
        
        let authType = Validator.checkAuthType(userInputText: registerUserCredentials.singInMeth)
        
        switch authType {
        case .email:
            interactor.registerUser(registerUserCredentials: registerUserCredentials)
        case .phone:
            interactor.registerUserByPhone(registerUserCredentials: registerUserCredentials)
        case .unknown:
            credentialsField.animateError()
        }
        
    }
    
    private func setupConstraints() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        usernameField.translatesAutoresizingMaskIntoConstraints = false
        credentialsField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        termsTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 222),
            
            usernameField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 12),
            usernameField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            usernameField.heightAnchor.constraint(equalToConstant: 56),
            usernameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            usernameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            credentialsField.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 12),
            credentialsField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            credentialsField.heightAnchor.constraint(equalToConstant: 56),
            credentialsField.leadingAnchor.constraint(equalTo: usernameField.leadingAnchor),
            credentialsField.trailingAnchor.constraint(equalTo: usernameField.trailingAnchor),
            
            passwordField.topAnchor.constraint(equalTo: credentialsField.bottomAnchor, constant: 24),
            passwordField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            passwordField.heightAnchor.constraint(equalToConstant: 56),
            passwordField.leadingAnchor.constraint(equalTo: credentialsField.leadingAnchor),
            passwordField.trailingAnchor.constraint(equalTo: credentialsField.trailingAnchor),
            
            signUpButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 24),
            signUpButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            signUpButton.heightAnchor.constraint(equalToConstant: 56),
            signUpButton.leadingAnchor.constraint(equalTo: credentialsField.leadingAnchor),
            signUpButton.trailingAnchor.constraint(equalTo: credentialsField.trailingAnchor),
            
            termsTextView.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 8),
            termsTextView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            termsTextView.leadingAnchor.constraint(equalTo: credentialsField.leadingAnchor),
            termsTextView.trailingAnchor.constraint(equalTo: credentialsField.trailingAnchor),
            
            signInButton.topAnchor.constraint(equalTo: termsTextView.bottomAnchor, constant: 12),
            signInButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            signInButton.heightAnchor.constraint(equalToConstant: 44),
            signInButton.leadingAnchor.constraint(equalTo: credentialsField.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: credentialsField.trailingAnchor),
            
        ])
    }
}

extension RegistrationViewController: UITextViewDelegate {
    // MARK: - Public methods
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        
        if URL.scheme == "terms" {
            showWebViewerController(with: "https://policies.google.com/terms?hl=en-US")
        } else if URL.scheme == "privacy" {
            showWebViewerController(with: "https://policies.google.com/privacy?hl=en-US")
        }
        return true
    }
    
    // MARK: - Private methods
    private func showWebViewerController(with urlString: String) {
        let vc = WebViewController(with: urlString)
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        textView.selectedTextRange = nil
        textView.delegate = self
    }
}

