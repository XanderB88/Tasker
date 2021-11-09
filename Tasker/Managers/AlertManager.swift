//
//  AlertManager.swift
//  Tasker
//
//  Created by Alexander on 09.11.2021.
//

import UIKit

class AlertManager {
    
    func showErrorAlert(withTitle title: String, withMessage message: String, withVC vc: UIViewController) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        
        vc.present(alertController, animated: true, completion: nil)
        
    }
    
    func showAddingAlert(withVC vc: UIViewController) {
        let alertController = UIAlertController(title: "New Task", message: "Add a new task", preferredStyle: .alert)
        
        alertController.addTextField()
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            guard let textField = alertController.textFields?.first, textField.text != "" else { return }
            
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        vc.present(alertController, animated: true, completion: nil)
    }
}
