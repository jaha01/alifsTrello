//
//  SetupService.swift
//  alifsTrello
//
//  Created by Jahongir Anvarov on 26.09.2024.
//

import Foundation

enum EntryScreen {
    case auth
    case mainTabBar
}

protocol SetupServiceProtocol {
    func getEntryScreen() ->  EntryScreen
}

final class SetupService: SetupServiceProtocol  {
    
    private let authService: AuthServiceProtocol
    
    
    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }
    
    func getEntryScreen() ->  EntryScreen {
        
        // Сюда можно было добавить начальный экран, когда юзер первый раз запустил приложение...

        if !authService.isCurrentUserExists() {
            return .auth
        }
        
        return .mainTabBar
        
    }
}
