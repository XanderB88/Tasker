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
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
       
        navigationController?.navigationBar.barTintColor = UIColor.green
       
    }

    @IBAction func addNewItemButton(_ sender: UIBarButtonItem) {
        alertManager.showAddingAlert(withVC: self)
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.backgroundColor = .clear
        
        cell.textLabel?.text = "Number of Row \(indexPath.row)"
        return cell
    }
    
}

// MARK: - Table view delegate
extension TasksViewController: UITableViewDelegate {
    
}
