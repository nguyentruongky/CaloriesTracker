//
//  AddUserWorker.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/27/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

struct CTCreateUserWorker {
    var email: String
    var password: String
    var name: String
    var success: (() -> Void)?
    var fail: ((knError) -> Void)?
    
    init(email: String, password: String,
         name: String,
         success: (() -> Void)?,
         fail: ((knError) -> Void)?) {
        self.email = email
        self.password = password
        self.name = name
        self.fail = fail
        self.success = success
    }
    
    func execute() {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, err) in
            if let error = err {
                self.fail?(knError(code: "create_fail", message: error.localizedDescription))
                return
            }
            guard let fbUserId = authResult?.user.uid else { return }
            self.success?()
            
            let user = CTUser(id: fbUserId, name: self.name, email: self.email, role: UserRole.user)
            let bucket = CTDataBucket.users.rawValue
            let db = Database.database().reference().child(bucket).child(fbUserId)
            db.setValue(user.toDict())
        }
    }
    
}
