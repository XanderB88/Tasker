//
//  User.swift
//  Tasker
//
//  Created by Alexander on 10.11.2021.
//

import Foundation
import Firebase

struct User {
    var uid: String
    var email: String
    
    init(user: Firebase.User) {
        self.uid = user.uid
        self.email = user.email!
    }
}
