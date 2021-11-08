//
//  ViewController.swift
//  Tasker
//
//  Created by Alexander on 06.11.2021.
//

import UIKit

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
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
    }
    
}

