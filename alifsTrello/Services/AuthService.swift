//
//  AuthService.swift
//  alifsTrello
//
//  Created by Jahongir Anvarov on 26.09.2024.
//

import Foundation

import FirebaseAuth
import FirebaseFirestore

protocol AuthServiceProtocol {
    func registerUser(with userCredentials: RegisterUserCredentials, completion: @escaping(Error?) -> Void)
    func signIn(with userCredentials: LoginUserCredentials, completion: @escaping(Error?)->Void)
    func signOut(completion: @escaping (Error?)->Void)
    func resetPassword(with email: String, completion: @escaping (Error?) -> Void)
    func isCurrentUserExists() -> Bool
}

final class AuthService: AuthServiceProtocol {
    
    private let isNotNewUserKey = "isNotNewUser"
    
    
    func registerUser(with userCredentials: RegisterUserCredentials, completion: @escaping(Error?) -> Void) {
        let username = userCredentials.username
        let email = userCredentials.singInMeth
        let password = userCredentials.password
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(error)
                return
            }
            
            guard let resultUser = result?.user else {
                completion(nil)
                return
            }
            
            let db = Firestore.firestore()
            db.collection("users")
                .document(resultUser.uid)
                .setData([
                    "username": username,
                    "email": email
                ]) { error in
                    if let error = error {
                        completion(error)
                        return
                    }
                    completion(nil)
                }
        }
    }
    
    func signIn(with userCredentials: LoginUserCredentials, completion: @escaping(Error?)->Void) {
        Auth.auth().signIn(withEmail: userCredentials.email, password: userCredentials.password) {
            result, error in
            completion(error)
        }
    }
    
    func signOut(completion: @escaping (Error?)->Void) {
        do {
            try Auth.auth().signOut()
            completion(nil)
        } catch let error {
            completion(error)
        }
    }
    
    func resetPassword(with email: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            completion(error)
        }
    }

    
    func isCurrentUserExists() -> Bool {
        return FirebaseAuth.Auth.auth().currentUser != nil
    }

}
