//
//  AlertManager.swift
//  Tasker
//
//  Created by Alexander on 09.11.2021.
//

import UIKit

class AlertManager {
    
    static let shared = AlertManager()
    
    func showAlert(withTitle title: String, withMessage message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let OkAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(OkAction)
        
        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.rootViewController = UIViewController()
        alertWindow.windowLevel = UIWindow.Level.alert + 1
        alertWindow.makeKeyAndVisible()
        alertWindow.rootViewController?.present(alertController, animated: true, completion: nil)
        
    }
}
