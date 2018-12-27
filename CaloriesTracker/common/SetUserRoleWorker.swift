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
        if roles.contains(appSetting.userRole) == false {
            failAction?(knError(code: "forbidden", message: "You don't have permission to do this"))
            return
        }
        
        if newRole == .admin && appSetting.userRole == .manager {
            failAction?(knError(code: "forbidden", message: "You don't have permission to do this"))
            return
        }
        
        let db = Helper.getUserDb()
        db.child(userId).child("role").setValue(newRole.rawValue)
        successAction?()
    }
}

