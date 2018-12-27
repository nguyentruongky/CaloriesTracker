//
//  DeleteUserWorker.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/27/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import Foundation
struct CTDeleteUserWorker {
    var userId: String
    private var successAction: (() -> Void)?
    private var failAction: ((knError) -> Void)?
    init(userId: String, successAction: (() -> Void)?, failAction: ((knError) -> Void)?) {
        self.userId = userId
        self.successAction = successAction
        self.failAction = failAction
    }
    
    func execute() {
        let db = Helper.getUserDb()
        db.child(userId).removeValue { (error, _) in
            if error == nil {
                self.successAction?()
            } else {
                self.failAction?(knError(code: "delete_fail", message: error!.localizedDescription))
            }
        }
    }
}

