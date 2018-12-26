//
//  RegisterWorker.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/20/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

struct CTRegisterWorker {
    var name: String
    var email: String
    var password: String
    var success: ((CTUser) -> Void)?
    var fail: ((knError) -> Void)?
    
    init(name: String, email: String, password: String,
         success: ((CTUser) -> Void)?,
         fail: ((knError) -> Void)?) {
        self.name = name
        self.email = email
        self.password = password
        self.fail = fail
        self.success = success
    }
    
    func execute() {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, err) in
            if let error = err {
                self.fail?(knError(code: "register_fail", message: error.localizedDescription))
                return
            }
            guard let fbUserId = authResult?.user.uid else { return }
            let user = CTUser(id: fbUserId, name: self.name, email: self.email, role: UserRole.user)
            self.success?(user)
            
            let bucket = CTDataBucket.users.rawValue
            let db = Database.database().reference().child(bucket).child(fbUserId)
            db.setValue(user.toDict())
        }
    }
}
