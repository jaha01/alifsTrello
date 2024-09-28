//
//  AlertManager.swift
//  alifsTrello
//
//  Created by Jahongir Anvarov on 26.09.2024.
//

import Foundation
import UIKit

struct AlertConfig {
    var title: String
    var message: String?
}

class AlertManager {
    
    public static func showAlert(config: AlertConfig, completion:  (() -> ())? = nil) {
        let topController = UIApplication.shared.getTopViewController()
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: config.title, message: config.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dissmiss", style: .default, handler: { action in
                completion?()
            }))
            topController.present(alert, animated: true)
        }
    }
    
    public static func addTaskItemAlert(completion: @escaping(String) -> Void) {
        let topController = UIApplication.shared.getTopViewController()
        let alert = UIAlertController(title: "Добавить", message: "Добавьте новую запись", preferredStyle: .alert)
        alert.addTextField { field in
            field.placeholder = "Введите запись"
        }
        alert.addAction(UIAlertAction(title: "Готово", style: .default, handler: { action in
            if let field = alert.textFields?.first, let text = field.text, !text.isEmpty {
                completion(text)
            }
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        topController.present(alert, animated: true)
    }
    
}
