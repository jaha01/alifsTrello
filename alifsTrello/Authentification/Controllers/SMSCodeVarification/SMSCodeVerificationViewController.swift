//
//  SMSCodeVerificationViewController.swift
//  alifsTrello
//
//  Created by Jahongir Anvarov on 26.09.2024.
//

import Foundation
import UIKit

protocol SMSCodeVerificationViewControllerProtocol: AnyObject {
    func showErrorAlert(config: AlertConfig)
}

final class SMSCodeVerificationViewController: UIViewController, SMSCodeVerificationViewControllerProtocol {
    
    // MARK: - Public properties
    
    var interactor: SMSCodeVerificationInteractorProtocol!
    
    // MARK: - Private properties
    
    private let codeField = AuthTextField(fieldType: .code)
    private let okButton = AuthButton(title: "OK", hasBackground: true, fontSize: .med)
    
    // MARK: - Public methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Введите код"
        view.backgroundColor = .systemBackground
        view.addSubview(codeField)
        view.addSubview(okButton)
        setupConstraints()
        okButton.addTarget(self, action: #selector(didTapOkButton), for: .touchUpInside)
    }
    
    func showErrorAlert(config: AlertConfig) {
        AlertManager.showAlert(config: config)
    }
    
    // MARK: - Private methods
    
    @objc private func didTapOkButton() {
        if let text = codeField.text, !text.isEmpty {
            interactor.verify(code: text)
        }
    }
    
    private func setupConstraints() {
        codeField.translatesAutoresizingMaskIntoConstraints = false
        okButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            codeField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            codeField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            codeField.heightAnchor.constraint(equalToConstant: 40),
            codeField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            codeField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -200),
            
            okButton.topAnchor.constraint(equalTo: codeField.bottomAnchor, constant: 20),
            okButton.centerXAnchor.constraint(equalTo: codeField.centerXAnchor),
            okButton.heightAnchor.constraint(equalToConstant: 40),
            okButton.leadingAnchor.constraint(equalTo: codeField.leadingAnchor),
            okButton.trailingAnchor.constraint(equalTo: codeField.trailingAnchor)
        ])
    }
}
