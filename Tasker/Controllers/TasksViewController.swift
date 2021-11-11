//
//  TasksViewController.swift
//  Tasker
//
//  Created by Alexander on 07.11.2021.
//

import UIKit
import Firebase

class TasksViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var alertManager = AlertManager()
    var user: User!
    var ref: DatabaseReference!
    var tasks = Array<Task>()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let currentUser = Auth.auth().currentUser else { return }
        
        user = User(user: currentUser)
        ref = Database.database().reference(withPath: "users").child(String(user.uid)).child("tasks")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        ref.observe(.value) { snapshot in
            var _tasks = Array<Task>()
            for item in snapshot.children {
                let task = Task(snapshot: item as! DataSnapshot)
                _tasks.append(task)
            }
            
            self.tasks = _tasks
            self.tableView.reloadData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        ref.removeAllObservers()
    }
    
    @IBAction func addNewItemButton(_ sender: UIBarButtonItem) {
        alertManager.showAddingAlert(withUser: user, withRef: ref, withVC: self)
    }
    
    @IBAction func signOutButtonPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        dismiss(animated: true)
    }
}


// MARK: - Table view data source
extension TasksViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // Cell configuration
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        
        var content = cell.defaultContentConfiguration()
        let task = tasks[indexPath.row]
        let isCompleted = task.completed
        
        // Configure content.
        content.text = task.title
        
        // Customize appearance.
        content.textProperties.color = .black
        cell.contentConfiguration = content
        
        toggleCompletion(forCell: cell, isCompleted: isCompleted)
        
        return cell
    }
    
}

// MARK: - Table view delegate
extension TasksViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        let task = tasks[indexPath.row]
        let isCompleted = !task.completed
        
        toggleCompletion(forCell: cell, isCompleted: isCompleted)
        task.ref?.updateChildValues(["completed": isCompleted])
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let task = tasks[indexPath.row]
            task.ref?.removeValue()
        }
    }
    
    func toggleCompletion(forCell cell: UITableViewCell, isCompleted: Bool) {
        
        cell.accessoryType = isCompleted ? .checkmark: .none
    }
}
