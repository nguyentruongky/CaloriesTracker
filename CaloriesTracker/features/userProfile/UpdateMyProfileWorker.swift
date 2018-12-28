//
//  UpdateMyProfileWorker.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/29/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import Foundation

struct CTUpdateMyProfileWorker {
    private var data: [String: Any]
    private var successAction: (() -> Void)?
    private var failAction: ((knError) -> Void)?
    init(data: [String: Any], successAction: (() -> Void)?, failAction: ((knError) -> Void)?) {
        self.data = data
        self.successAction = successAction
        self.failAction = failAction
    }
    
    func execute() {
        guard let userId = appSetting.userId else { return }
        let db = Helper.getUserDb().child(userId)
        for (key, value) in data {
            db.child(key).setValue(value)
        }
        
        successAction?()
    }
}

