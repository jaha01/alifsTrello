//
//  UIApplication+TopViewController.swift
//  alifsTrello
//
//  Created by Jahongir Anvarov on 26.09.2024.
//

import UIKit

extension UIApplication {
    
    func getTopViewController() -> UIViewController {
        guard let base = UIApplication.shared.connectedScenes.compactMap { ($0 as? UIWindowScene)?.keyWindow }.last?.rootViewController else {
            return UIViewController()
       }
       
        return getTopViewControllerRecursive(base: base)
    }
    
    private func getTopViewControllerRecursive(base: UIViewController) -> UIViewController {
        if let nav = base as? UINavigationController {
            return getTopViewControllerRecursive(base: nav.visibleViewController!)
            
        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewControllerRecursive(base: selected)
            
        } else if let presented = base.presentedViewController {
            return getTopViewControllerRecursive(base: presented)
        }
        return base
    }
}
