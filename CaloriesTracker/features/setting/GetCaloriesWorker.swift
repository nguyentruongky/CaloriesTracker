//
//  GetCaloriesWorker.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/26/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

struct CTGetCaloriesWorker {
    private var successAction: ((Int) -> Void)?
    init(successAction: ((Int) -> Void)?) {
        self.successAction = successAction
    }
    
    func execute() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let bucket = CTDataBucket.users.rawValue
        let db = Database.database().reference().child(bucket).child(uid)
        db.child("calories_limit").observeSingleEvent(of: .value) { (snapshot) in
            print(snapshot.value)
            let value = snapshot.value as? Int ?? appSetting.standardCalories
            self.successAction?(value)
        }
    }
}

