//
//  SetUserRoleWorker.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/26/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

struct CTSetUserRoleWorker {
    var role: UserRole
    var userId: String
    private var successAction: (() -> Void)?
    private var failAction: ((knError) -> Void)?
    init(role: UserRole, userId: String, successAction: (() -> Void)?, failAction: ((knError) -> Void)?) {
        self.role = role
        self.userId = userId
        self.successAction = successAction
        self.failAction = failAction
    }
    
    func execute() {
        guard let myId = Auth.auth().currentUser?.uid else {
            failAction?(knError(code: "no_user_data"))
            return
        }
        if myId != appSetting.ADMIN {
            failAction?(knError(code: "forbidden"))
            return
        }
        
        let bucket = CTDataBucket.users.rawValue
        let ref = Database.database().reference().child(bucket)
        ref.child(userId).child("role").setValue(role.rawValue)
        successAction?()
    }
}

