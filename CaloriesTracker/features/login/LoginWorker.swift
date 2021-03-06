//
//  LoginWorker.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/20/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

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
            
            guard let fbUserId = result?.user.uid else {
                self.fail?(knError(code: "no_user_data"))
                return
            }
            
            let db = CTDataBucket.getUserDb()
            db.child(fbUserId).observeSingleEvent(of: .value, with: { (snapshot) in
                let rawData = snapshot.value as AnyObject
                let isActive = rawData["is_active"] as? Bool ?? true
                if isActive == false {
                    self.fail?(knError(code: "inactive", message: "Your account is deactivated because of violation. Please contact to help@caloriestracker.com to get help"))
                    try? Auth.auth().signOut()
                    return
                }
                
                let isDeleted = rawData["is_deleted"] as? Bool ?? false
                if isDeleted {
                    self.fail?(knError(code: "deleted", message: "Your account is deleted because of violation. Please contact to help@caloriestracker.com to get help"))
                    try? Auth.auth().signOut()
                    return
                }
                
                let user = CTUser(raw: rawData)
                self.success?(user)
            })
            
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
