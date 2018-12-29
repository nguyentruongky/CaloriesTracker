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
    var newRole: UserRole
    var userId: String
    private var successAction: (() -> Void)?
    private var failAction: ((knError) -> Void)?
    init(role: UserRole, userId: String, successAction: (() -> Void)?, failAction: ((knError) -> Void)?) {
        self.newRole = role
        self.userId = userId
        self.successAction = successAction
        self.failAction = failAction
    }
    
    func execute() {
        let roles: [UserRole] = [.admin, .manager]
        let noPermissionMessage = "You don't have permission to do this"
        if roles.contains(appSetting.userRole) == false {
            failAction?(knError(code: "forbidden", message: noPermissionMessage))
            return
        }
        
        if newRole == .admin && appSetting.userRole == .manager {
            failAction?(knError(code: "forbidden", message: noPermissionMessage))
            return
        }
        
        let db = CTDataBucket.getUserDb()
        db.child(userId).child("role").setValue(newRole.rawValue)
        successAction?()
    }
}

