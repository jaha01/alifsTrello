//
//  AuthService.swift
//  alifsTrello
//
//  Created by Jahongir Anvarov on 26.09.2024.
//

import FirebaseAuth
import FirebaseFirestore

protocol AuthServiceProtocol {
//    func isNewUser() -> Bool
//    func setIsNotNewUser()
    func registerUser(with userCredentials: RegisterUserCredentials, completion: @escaping(Error?) -> Void)
    func signIn(with userCredentials: LoginUserCredentials, completion: @escaping(Error?)->Void)
    func signOut(completion: @escaping (Error?)->Void)
    func resetPassword(with email: String, completion: @escaping (Error?) -> Void)
    func fetchUser(completion: @escaping (User?, Error?) -> Void)
    func isCurrentUserExists() -> Bool
    func getUserID() -> String
    func getUserEmail() -> String
    func verifyCode(verificationId: String, smsCode: String, completion: @escaping (Error?) -> Void)
    func registerByPhone(phoneNumber: String, completion: @escaping(String?, Error?) -> Void)
}

final class AuthService: AuthServiceProtocol {
    
//    private let isNotNewUserKey = "isNotNewUser"
//    
//    func isNewUser() -> Bool {
//        return !UserDefaults.standard.bool(forKey: isNotNewUserKey)
//    }
    
//    func setIsNotNewUser() {
//        UserDefaults.standard.set(true, forKey: isNotNewUserKey)
//    }
    
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
    
    func fetchUser(completion: @escaping (User?, Error?) -> Void) {
        
        guard let userUID = Auth.auth().currentUser?.uid else { return }
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(userUID)
            .getDocument { snapshot, error in
                if let error = error {
                    completion(nil, error)
                    return
                }
                if let snapshot = snapshot,
                   let snapshotData = snapshot.data(),
                   let username = snapshotData["username"] as? String,
                   let email = snapshotData["email"] as? String {
                    let user = User(username: username, email: email, userUID: userUID)
                    completion(user, nil)
                } else {
                    completion(nil, NetworkError.fetching("Local Error while log in"))
                }
            }
    }
    
    func isCurrentUserExists() -> Bool {
        return FirebaseAuth.Auth.auth().currentUser != nil
    }
    
    func getUserID() -> String {
        guard let userID = Auth.auth().currentUser?.uid else { return ""}
        return userID
    }
    
    func getUserEmail() -> String {
        guard let email = Auth.auth().currentUser?.email else { return ""}
        return email
    }
    
    func registerByPhone(phoneNumber: String, completion: @escaping(String?, Error?) -> Void) {
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationId, error in
            guard let verificationId = verificationId, error == nil else {
                return completion(nil, error)
            }
            completion(verificationId, nil)
        }
    } // ткни пальцем на ошибку я слепой😂
    
    func verifyCode(verificationId: String, smsCode: String, completion: @escaping (Error?) -> Void) {

        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationId, verificationCode: smsCode)
        
        Auth.auth().signIn(with: credential) { result, error in
            guard result != nil, error == nil else {
                completion(error)
                return
            }
            completion(nil)
        }
    }

}
