//
//  LoginWorker.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/20/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import Foundation
import FirebaseAuth

class CTUser {
    var email: String?
    var name: String?
    var userId: String?
    var avatar: String?
    
    init() { }
    init(name: String, avatar: String) {
        self.name = name
        self.avatar = avatar
    }
}

struct CTLoginWorker {
    var email: String
    var password: String
    var success: ((CTUser) -> Void)?
    var fail: ((knError) -> Void)?
    
    init(email: String, password: String,
         success: ((CTUser) -> Void)?,
         fail: ((knError) -> Void)?) {
        self.email = email
        self.password = password
        self.fail = fail
        self.success = success
    }
    
    func execute() {
        Auth.auth().signIn(withEmail: email, password: password) { (result, err) in
            if let error = err {
                self.fail?(knError(code: "login_fail", message: error.localizedDescription))
                return
            }
            if let fbUser = result?.user {
                let user = self.mapUser(from: fbUser)
                self.success?(user)
            }
        }
    }
    
    private func mapUser(from fbUser: User) -> CTUser {
        let user = CTUser()
        user.name = fbUser.displayName
        user.email = email
        user.userId = fbUser.providerID
        return user
    }
}
