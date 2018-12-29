//
//  UpdateCaloriesWorker.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/26/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

struct CTUpdateCaloriesWorker {
    private var calories: Int
    private var successAction: (() -> Void)?
    private var failAction: ((knError) -> Void)?
    init(calories: Int) {
        self.calories = calories
    }
    
    func execute() {
        guard let uid = appSetting.userId else { return }
        let bucket = CTDataBucket.users.rawValue
        let db = Database.database().reference().child(bucket).child(uid)
        db.child("calories_limit").setValue(calories)
    }
}

