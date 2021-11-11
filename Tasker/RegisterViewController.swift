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
    
    var ref: DatabaseReference!
    
    var alertManager = AlertManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference(withPath: "users")
        
        self.addKeyboardObservers()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.emailTextField.text = ""
        self.passwordTextField.text = ""
        
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              email != "",
              password != "" else {
                  return alertManager.showErrorAlert(withTitle: "Fields are not filling", withMessage: "Please fill in all fields", withVC: self)
              }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            
            
            guard let self = self, let user = authResult?.user, error == nil else {
                
                if error?.localizedDescription == "The email address is badly formatted." {
                    self!.alertManager.showErrorAlert(withTitle: "Error", withMessage: "Please check the email address, it has wrong format", withVC: self!)
                }
                return
            }
            
            let userRef = self.ref.child(user.uid)
            userRef.setValue(["email": user.email])
            self.performSegue(withIdentifier: "signUpTasks", sender: self)
            
        }
        
    }
    
}
