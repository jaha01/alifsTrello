//
//  AuthTextField.swift
//  alifsTrello
//
//  Created by Jahongir Anvarov on 26.09.2024.
//

import UIKit

class AuthTextField: UITextField {
    
    enum AuthTextFieldType {
        case username
        case credentials
        case password
        case code
    }
    
    private let authFieldType: AuthTextFieldType
    
    init(fieldType: AuthTextFieldType) {
        authFieldType = fieldType
        super.init(frame: .zero)
        
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 10
        
        returnKeyType = .done
        autocorrectionType = .no
        autocapitalizationType = .none
        translatesAutoresizingMaskIntoConstraints = false
        
        leftViewMode = .always
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: frame.size.height))
        
        switch fieldType {
        case .username:
            placeholder = "Имя пользователя"
        case .credentials:
            placeholder = "Email или номер телефона"
            keyboardType = .emailAddress
            textContentType = .emailAddress
        case .password:
            placeholder = "Пароль"
            textContentType = .oneTimeCode
            isSecureTextEntry = true
        case .code:
            placeholder = "Код"
            textContentType = .oneTimeCode
            keyboardType = .numberPad
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension UITextField {
    func animateError() {
        textColor = .red
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.textColor = .black
        }
    }
}
