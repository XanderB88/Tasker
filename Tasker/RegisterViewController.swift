//
//  RegisterViewController.swift
//  Tasker
//
//  Created by Alexander on 08.11.2021.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.addKeyboardObservers()
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        guard let email = emailTextField.text,
                      let password = passwordTextField.text,
                          email != "",
                          password != "" else {
                              return AlertManager.shared.showAlert(withTitle: "Fields are not filling", withMessage: "Please fill in all fields")
                }
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print(error)
            } else {
                self.performSegue(withIdentifier: "signUpTasks", sender: self)
            }
        }
        
    }
    
}
