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
    private var email: String
    private var password: String
    private var name: String
    private var successAction: (() -> Void)?
    private var failAction: ((knError) -> Void)?
    
    init(email: String, password: String,
         name: String,
         success: (() -> Void)?,
         fail: ((knError) -> Void)?) {
        self.email = email
        self.password = password
        self.name = name
        self.failAction = fail
        self.successAction = success
    }
    
    func execute() {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, err) in
            if let error = err {
                self.failAction?(knError(code: "create_fail", message: error.localizedDescription))
                return
            }
            guard let fbUserId = authResult?.user.uid else { return }
            self.successAction?()
            
            let user = CTUser(id: fbUserId, name: self.name, email: self.email, role: UserRole.user)
            let bucket = CTDataBucket.users.rawValue
            let db = Database.database().reference().child(bucket).child(fbUserId)
            db.setValue(user.toDict())
        }
    }
    
}
