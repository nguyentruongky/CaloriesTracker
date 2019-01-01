//
//  GetAllUsersWorker.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/27/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import Foundation
import FirebaseAuth

struct CTGetAllUsersWorker {
    private var successAction: (([CTUser]) -> Void)?
    private var failAction: ((knError) -> Void)?
    init(successAction: (([CTUser]) -> Void)?, failAction: ((knError) -> Void)?) {
        self.successAction = successAction
        self.failAction = failAction
    }
    
    func execute() {
        let db = CTDataBucket.getUserDb()
        db.observeSingleEvent(of: .value) { (snapshot) in
            guard var raws = snapshot.value as? [String: AnyObject] else {
                self.failAction?(knError(code: "no_data"))
                return
            }
            
            var users = Array(raws.values).map({ return CTUser(raw: $0) })
            users = users.filter({ return $0.isDeleted == false })
            users.sort(by: { return ($0.name ?? "") < ($1.name ?? "") })
            if let index = users.firstIndex(where: { return $0.userId == appSetting.userId }) {
                let me = users.remove(at: index)
                users.insert(me, at: 0)
            }
            
            self.successAction?(users)
        }
    }
}

