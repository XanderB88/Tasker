//
//  TasksViewController.swift
//  Tasker
//
//  Created by Alexander on 07.11.2021.
//

import UIKit

class TasksViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
       
        navigationController?.navigationBar.barTintColor = UIColor.green
       
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func addNewItemButton(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func signOutButtonPressed(_ sender: UIBarButtonItem) {
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
