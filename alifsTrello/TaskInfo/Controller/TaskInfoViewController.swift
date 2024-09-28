//
//  TaskInfoViewController.swift
//  alifsTrello
//
//  Created by Jahongir Anvarov on 27.09.2024.
//

import UIKit


protocol TaskInfoViewControllerProtocol: AnyObject {
    func getUsers(users: [String])
}

protocol TaskInfoDelegate: AnyObject {
    func update(item: TaskItem)
}

final class TaskInfoViewController: UIViewController, TaskInfoViewControllerProtocol {
    
    // MARK: - Properties
    
    var interactor: TaskInfoInteractorProtocol!
    weak var delegate: TaskInfoDelegate?
    var item: TaskItem!
    private var executors = [String]()

    private let descriptionField: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.isScrollEnabled = true
        textView.layer.cornerRadius = 8
        textView.textContainer.lineBreakMode = .byWordWrapping
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .secondarySystemBackground
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 0, right: 5) // отступы
        return textView
    }()
    
    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        let localID = Locale.preferredLanguages.first
        picker.locale = Locale(identifier: localID!)
        return picker
    }()
    
    private let dateField: UITextField = {
        let textField = UITextField()
        textField.text = "Срок"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.cornerRadius = 4
        return textField
    }()
    
    private let executor: UITextField = {
        let textField = UITextField()
        textField.text = "Исполнитель"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.cornerRadius = 4
        return textField
    }()
    
    private let picker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    private let state: UITextField = {
        let textField = UITextField()
        textField.text = "Cтатус"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.cornerRadius = 4
        return textField
    }()
    
    private let statePicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    private let comments: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "CommentsCell")
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .green
        table.layer.cornerRadius = 8
        table.layer.borderWidth = 4
        table.layer.borderColor = CGColor(red: 255, green: 0, blue: 0, alpha: 0)
        return table
    }()
    
    private let newCommentField: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.isScrollEnabled = true
        textView.layer.cornerRadius = 8
        textView.textContainer.lineBreakMode = .byWordWrapping
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .secondarySystemBackground
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 0, right: 5) // отступы
        return textView
    }()
    
    private let addCommentButton = AuthButton(title: "Добавить", fontSize: .small)
    private let cancelButton = AuthButton(title: "Отмена", fontSize: .small)
    
    // MARK: - Public methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = item.title
        view.addSubview(descriptionField)
        view.addSubview(dateField)
        view.addSubview(executor)
        view.addSubview(state)
        view.addSubview(comments)
        view.addSubview(newCommentField)
        view.addSubview(addCommentButton)
        view.addSubview(cancelButton)
        setConstraints()
        setup()
        interactor.getUsers()
        getTaskItem(item: item)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(didTapSave))

    }
    
    
    func getUsers(users: [String]) {
        executors = users
    }
    
    // MARK: - Private properties
    
    
    private func getTaskItem(item: TaskItem) {
        dateField.text = item.dueDate
        state.text = item.status
        descriptionField.text = item.description
        executor.text = item.assignee
    }
    
    @objc private func didTapSave() {
        item.dueDate = dateField.text
        item.status = state.text
        item.description = descriptionField.text
        item.assignee = executor.text
        item.comments.append(newCommentField.text)
        delegate?.update(item: item)
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            descriptionField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            descriptionField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            descriptionField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            descriptionField.bottomAnchor.constraint(equalTo: descriptionField.topAnchor, constant: 100),
            
            executor.topAnchor.constraint(equalTo: descriptionField.bottomAnchor, constant: 20),
            executor.leadingAnchor.constraint(equalTo: descriptionField.leadingAnchor),
            executor.trailingAnchor.constraint(equalTo: executor.leadingAnchor, constant: 140),
            executor.bottomAnchor.constraint(equalTo: executor.topAnchor, constant: 32),
            
            dateField.topAnchor.constraint(equalTo: executor.topAnchor),
            dateField.leadingAnchor.constraint(equalTo: executor.trailingAnchor, constant: 20),
            dateField.trailingAnchor.constraint(equalTo: dateField.leadingAnchor, constant: 100),
            dateField.bottomAnchor.constraint(equalTo: executor.bottomAnchor),
            
            state.topAnchor.constraint(equalTo: executor.topAnchor),
            state.leadingAnchor.constraint(equalTo: dateField.trailingAnchor, constant: 20),
            state.trailingAnchor.constraint(equalTo: descriptionField.trailingAnchor),
            state.bottomAnchor.constraint(equalTo: executor.bottomAnchor),
            
            addCommentButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12),
            addCommentButton.trailingAnchor.constraint(equalTo: descriptionField.trailingAnchor),
            addCommentButton.leadingAnchor.constraint(equalTo: addCommentButton.trailingAnchor, constant: -80),
            addCommentButton.topAnchor.constraint(equalTo: addCommentButton.bottomAnchor, constant: -20),
            
            cancelButton.topAnchor.constraint(equalTo: addCommentButton.topAnchor),
            cancelButton.trailingAnchor.constraint(equalTo: addCommentButton.leadingAnchor, constant: -12),
            cancelButton.leadingAnchor.constraint(equalTo: cancelButton.trailingAnchor, constant: -80),
            cancelButton.bottomAnchor.constraint(equalTo: addCommentButton.bottomAnchor),
            
            newCommentField.bottomAnchor.constraint(equalTo: addCommentButton.topAnchor, constant: -12),
            newCommentField.topAnchor.constraint(equalTo: newCommentField.bottomAnchor, constant: -48),
            newCommentField.leadingAnchor.constraint(equalTo: descriptionField.leadingAnchor),
            newCommentField.trailingAnchor.constraint(equalTo: descriptionField.trailingAnchor),
            
            comments.topAnchor.constraint(equalTo: state.bottomAnchor, constant: 20),
            comments.leadingAnchor.constraint(equalTo: descriptionField.leadingAnchor),
            comments.trailingAnchor.constraint(equalTo: descriptionField.trailingAnchor),
            comments.bottomAnchor.constraint(equalTo: newCommentField.topAnchor, constant: -12),
        ])
    }
    
    private func setup() {
        dateField.inputView = datePicker
        executor.inputView = picker
        state.inputView = statePicker
        picker.dataSource = self
        picker.delegate = self
        statePicker.delegate = self
        statePicker.dataSource = self
        comments.delegate = self
        comments.dataSource = self
        
        addCommentButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        addCommentButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([flexSpace, doneButton], animated: true)
        dateField.inputAccessoryView = toolbar
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
    }
    
    @objc private func doneAction() {
        view.endEditing(true)
    }
    
    @objc private func dateChanged() {
        pickersDate()
    }
    
    private func pickersDate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        dateField.text = formatter.string(from: datePicker.date)
    }
    
    @objc private func didTapAddButton() {
        print("ADD COMMENT")
    }
    
    @objc private func didTapCancelButton() {
        newCommentField.text = ""
    }
    
    private func getStatusDescription(for index: Int) -> String? {
        if TaskStatus.allCases.indices.contains(index) {
            let status = TaskStatus.allCases[index]
            return status.rawValue
        }
        return nil
    }
}


extension TaskInfoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == picker {
            return executors.count
        } else {
            return TaskStatus.count()
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == picker {
            return executors[row]
        } else {
             return getStatusDescription(for: row)
            }
        }

func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    if pickerView == picker {
        executor.text = executors[row]
        executor.resignFirstResponder()
    } else {
        state.text = getStatusDescription(for: row)
        state.resignFirstResponder()
    }
}
// В UIPickerView можно было как с датой добавить кнопку done, но в целях экономии времени оставлю так
}

extension TaskInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentsCell", for: indexPath)
        cell.textLabel?.text = "TEST"
        return cell
    }
    
}
