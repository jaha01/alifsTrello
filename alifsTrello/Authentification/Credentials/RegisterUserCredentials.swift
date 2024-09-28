//
//  RegisterUserCredentials.swift
//  alifsTrello
//
//  Created by Jahongir Anvarov on 26.09.2024.
//

import Foundation

struct RegisterUserCredentials {
    let username: String
    let singInMeth: String
    let password: String
}


enum AuthType {
    case email
    case phone
    case unknown
}
