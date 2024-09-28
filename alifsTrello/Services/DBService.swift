//
//  DBService.swift
//  alifsTrello
//
//  Created by Jahongir Anvarov on 27.09.2024.
//

import FirebaseDatabase
import FirebaseAuth
import FirebaseFirestore

protocol TasksItemServiceProtocol {
    func setupTaskListener(handler: @escaping ([TaskItem]) -> Void)
    func uploadTaskItem(item: TaskItem, completion: @escaping (Result<Void, Error>) -> Void)
    func removeTaskItem(id: String)
    func fetchUsers(completion: @escaping ([String: [String: Any]]) -> Void)
    func updateTaskItem(item: TaskItem, completion: @escaping (Result<Void, Error>) -> Void)
}

final class DBService: TasksItemServiceProtocol {
    
    private let ref = Database.database().reference()
    private var allItems = [TaskItem]()
    private let authService: AuthServiceProtocol
    private let tasksHistoryItems = "tasksHistoryItems"

    
    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }
    
    func setupTaskListener(handler: @escaping ([TaskItem]) -> Void) {
        ref.child(authService.getUserID()).child(tasksHistoryItems).observe(.value) { [weak self] snapshot in
            guard let self = self else { return }
            if let dictionary = snapshot.value as? [String: Any] {
                self.allItems = []
                for (_, value) in dictionary {
                    if let itemData = value as? [String: Any] {
                        let taskItem = TaskItem(dictionary: itemData)
                        self.allItems.append(taskItem)
                    }
                }
                handler(self.allItems)
            }
        }
    }

    func uploadTaskItem(item: TaskItem, completion: @escaping (Result<Void, Error>) -> Void) {
        let parent = ref.child(authService.getUserID()).child(tasksHistoryItems)
        let id = parent.childByAutoId()
        
        // Prepare the values dictionary with correct types
        let values: [String: Any] = [
            "title": item.title,
            "id": id.key ?? "",
            "description": item.description ?? "",
            "assignee": item.assignee ?? "",
            "dueDate": item.dueDate ?? "",
            "status": item.status,
            "comments": item.comments
        ]
        
        id.updateChildValues(values) { error, _ in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func updateTaskItem(item: TaskItem, completion: @escaping (Result<Void, Error>) -> Void) {
        let itemRef = ref.child(authService.getUserID()).child(tasksHistoryItems).child(item.id)
        
        // Prepare the values dictionary with updated fields
        let values: [String: Any] = [
            "title": item.title,
            "description": item.description ?? "",
            "assignee": item.assignee ?? "",
            "dueDate": item.dueDate ?? "",
            "status": item.status,
            "comments": item.comments
        ]
        
        itemRef.updateChildValues(values) { error, _ in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }

    
    func removeTaskItem(id: String) {
        ref.child(authService.getUserID()).child(tasksHistoryItems).child(id).removeValue()
    }
    
    func fetchUsers(completion: @escaping ([String: [String: Any]]) -> Void) {
        let db = Firestore.firestore()
        db.collection("users").getDocuments { (snapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                completion([:])
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("No documents")
                completion([:])
                return
            }
            
            var users: [String: [String: Any]] = [:]
            
            for document in documents {
                let data = document.data()
                let uid = document.documentID
                users[uid] = data
            }
            
            completion(users)
        }
    }
}
