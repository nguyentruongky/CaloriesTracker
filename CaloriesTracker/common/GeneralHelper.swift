//
//  GeneralHelper.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/27/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Helper {
    static func getUserDb() -> DatabaseReference {
        let bucket = CTDataBucket.users.rawValue
        let db = Database.database().reference().child(bucket)
        return db
    }
    
    static func generateId() -> String {
        return UUID().uuidString
    }
}
