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
        
        cell.backgroundColor = .clear
        
        var content = cell.defaultContentConfiguration()
        
        // Configure content.
        content.text = tasks[indexPath.row].title
        
        // Customize appearance.
        content.textProperties.color = .black
        cell.contentConfiguration = content
        
        return cell
    }
    
}

// MARK: - Table view delegate
extension TasksViewController: UITableViewDelegate {
    
}
