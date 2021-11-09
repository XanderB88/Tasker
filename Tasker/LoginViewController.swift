//
//  ViewController.swift
//  Tasker
//
//  Created by Alexander on 06.11.2021.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    var alertManager = AlertManager()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addKeyboardObservers()
        self.hideKeyboardWhenTappedAround()
        
        Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            if user != nil {
                self?.performSegue(withIdentifier: "showTasks", sender: nil)
            }
        }
    }
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
                  email != "",
                  password != "" else {
                      return alertManager.showErrorAlert(withTitle: "Fields are not filling", withMessage: "Please fill in all fields", withVC: self)
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                
                guard let self = self else { return }
                
                if error.localizedDescription == "The email address is badly formatted." {
                    self.alertManager.showErrorAlert(withTitle: "Error", withMessage: "Please check the email address, it has wrong format", withVC: self)
                } else {
                    
                    self.alertManager.showErrorAlert(withTitle: "Error", withMessage: "User does not exist, please check your email or password.", withVC: self)
                }
                
            } else {
                self?.performSegue(withIdentifier: "showTasks", sender: self)
            }
        }
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
    }
}

