//
//  DeactivateUserWorker.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/27/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import Foundation

struct CTSetUserStatusWorker {
    var userId: String
    var isActive: Bool
    private var successAction: (() -> Void)?
    private var failAction: ((knError) -> Void)?
    init(userId: String, isActive: Bool, successAction: (() -> Void)?, failAction: ((knError) -> Void)?) {
        self.userId = userId
        self.isActive = isActive
        self.successAction = successAction
        self.failAction = failAction
    }
    
    func execute() {
        let db = CTDataBucket.getUserDb()
        db.child(userId).child("is_active").setValue(isActive)
        successAction?()
    }
}

