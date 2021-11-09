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
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addKeyboardObservers()
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
                  email != "",
                  password != "" else {
                      return AlertManager.shared.showAlert(withTitle: "Fields are not filling", withMessage: "Please fill in all fields")
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                
                if error.localizedDescription == "The email address is badly formatted." {
                    AlertManager.shared.showAlert(withTitle: "Error", withMessage: "Please check the email address, it has wrong format")
                } else {
                    AlertManager.shared.showAlert(withTitle: "Error", withMessage: "User does not exist, please check your email or password.")
                }
                
            } else {
                self?.performSegue(withIdentifier: "showTasks", sender: self)
            }
        }
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
    }
}

