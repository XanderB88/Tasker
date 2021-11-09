//
//  AlertManager.swift
//  Tasker
//
//  Created by Alexander on 09.11.2021.
//

import UIKit

class AlertManager {
    
    static let shared = AlertManager()
    
    func showAlert(withTitle title: String, withMessage message: String, withVC vc: UIViewController) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let OkAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(OkAction)
        
        vc.present(alertController, animated: true, completion: nil)
        
    }
}
