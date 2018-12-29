//
//  GetMyProfileWorker.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/26/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

struct CTGetProfileWorker {
    var userId: String
    private var successAction: ((CTUser) -> Void)?
    private var failAction: ((knError) -> Void)?
    init(userId: String, successAction: ((CTUser) -> Void)?, failAction: ((knError) -> Void)?) {
        self.userId = userId
        self.successAction = successAction
        self.failAction = failAction
    }
    
    func execute() {
        let roles: [UserRole] = [.admin, .manager]
        var hasPermission = true
        if roles.contains(appSetting.userRole) == false {
            hasPermission = userId == appSetting.userId
        }
        
        guard hasPermission else {
            failAction?(knError(code: "forbidden", message: "You don't have permission to view this profile"))
            return
        }
        
        let db = CTDataBucket.getUserDb()
        db.queryOrdered(byChild: "user_id")
            .queryEqual(toValue: userId)
            .observeSingleEvent(of: .value, with: { (snapshot) in
                guard let rawData = snapshot.value as? [String: AnyObject],
                    let raw = rawData.first?.value else {
                    let error = knError(code: "no_data")
                    self.failAction?(error)
                    return
                }
                
                let user = CTUser(raw: raw)
                self.successAction?(user)

        }) { (err) in
            let error = knError(code: "no_data", message: err.localizedDescription)
            self.failAction?(error)
        }
        
    }
}

