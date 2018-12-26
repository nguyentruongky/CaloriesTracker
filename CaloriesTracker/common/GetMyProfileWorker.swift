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

struct CTGetMyProfileWorker {
    private var successAction: ((CTUser) -> Void)?
    private var failAction: ((knError) -> Void)?
    init(successAction: ((CTUser) -> Void)?, failAction: ((knError) -> Void)?) {
        self.successAction = successAction
        self.failAction = failAction
    }
    
    func execute() {
        guard let userRaw = Auth.auth().currentUser else {
            failAction?(knError(code: "no_user_data"))
            return
        }
        
        let db = Helper.getUserDb()
        
        db.queryOrdered(byChild: "user_id")
            .queryEqual(toValue: userRaw.uid)
            .observeSingleEvent(of: .value, with: { (snapshot) in
                guard let _ = snapshot.value as? [String: AnyObject] else {
                    let error = knError(code: "no_data")
                    self.failAction?(error)
                    return
                }
            
                let raw = snapshot.value as AnyObject
                let user = CTUser(raw: raw)
                self.successAction?(user)

        }) { (err) in
            let error = knError(code: "no_data", message: err.localizedDescription)
            self.failAction?(error)
        }
        
    }
}

