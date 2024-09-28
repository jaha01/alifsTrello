//
//  DI.swift
//  alifsTrello
//
//  Created by Jahongir Anvarov on 26.09.2024.
//

import Foundation

final class DI {
    
    static let shared = DI()
    
    lazy var authService : AuthService = {
        return AuthService()
    }()
    
    func createSetupService() -> SetupService {
        return SetupService(authService: authService)
    }
    
    func dbService() -> DBService {
        return DBService(authService: authService)
    }
}
