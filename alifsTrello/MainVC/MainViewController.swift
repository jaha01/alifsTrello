//
//  ViewController.swift
//  alifsTrello
//
//  Created by Jahongir Anvarov on 26.09.2024.
//

import UIKit

protocol MainViewControllerProtocol: AnyObject {
    func showErrorAlert(config: AlertConfig)
    func showTasks(_ items: [TaskItem])
}

final class MainViewController: UIViewController, MainViewControllerProtocol {

    // MARK: - Properties
    
    var interactor: MainInteractorProtocol!

    private var items = [TaskItem]()
    
    private let tasksList: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private let emptyListImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "emptyList")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    // MARK: - Public methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Список задач"
        view.addSubview(tasksList)
        view.addSubview(emptyListImage)
        tasksList.delegate = self
        tasksList.dataSource = self
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        setConstraints()
        interactor.onViewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Выйти", style: .plain, target: self, action: #selector(didTapLogout))
        
    }
    
    func showErrorAlert(config: AlertConfig) {
        AlertManager.showAlert(config: config)
    }
    
    func showTasks(_ items: [TaskItem]) {
        self.items = items
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tasksList.isHidden = self.items.isEmpty
            self.emptyListImage.isHidden = !self.items.isEmpty
            self.tasksList.reloadData()
        }
    }

    // MARK: - Private methods
    @objc private func didTapLogout() {
        interactor.didTapSignOut()
    }
    
    @objc private func didTapAdd() {
        AlertManager.addTaskItemAlert { [weak self] text in
            guard let self = self else { return }
            
            self.interactor.appendItem(item: TaskItem(dictionary: [
                "title": text,
                "id": "",
                "description": "",
                "assignee": "",
                "dueDate": "",
                "status": "",
                "comments": [String]()
            ]))
        }
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            tasksList.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tasksList.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tasksList.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tasksList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            emptyListImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            emptyListImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            emptyListImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            emptyListImage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}


extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.items[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            interactor.deleteItem(id: self.items[indexPath.row].id)
            self.items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor.goToTaskInfo(item: self.items[indexPath.row])
    }
}

extension MainViewController: TaskInfoDelegate {
    func update(item: TaskItem) {
        print("!!!!!!!!!  TaskInfoDelegate")
        interactor.updateTaskItem(item: item)
    }
}
