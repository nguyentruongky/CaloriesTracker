//
//  RegisterWorker.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/20/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import Foundation
import FirebaseAuth

struct snRegisterWorker {
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
            if let fbUser = authResult?.user {
                let user = self.mapUser(from: fbUser)
                self.success?(user)
            }

            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
            changeRequest?.displayName = self.name
            changeRequest?.commitChanges(completion: nil)
        }
    }
    
    private func mapUser(from fbUser: User) -> CTUser {
        let user = CTUser()
        user.name = name
        user.email = email
        user.userId = fbUser.providerID
        return user
    }
}
