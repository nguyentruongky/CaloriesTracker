//
//  MealEnums.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/23/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit
import FirebaseDatabase

enum CTMealType: String {
    case breakfast, lunch, dinner, collation
}

enum UserRole: String {
    case user, manager, admin
}

enum CTStorageBucket: String {
    case avatar
}

enum CTDataBucket: String {
    case users, foods, meals
    static func getUserDb() -> DatabaseReference {
        return getDb(bucket: CTDataBucket.users.rawValue)
    }
    
    static func getMealDb() -> DatabaseReference {
        return getDb(bucket: CTDataBucket.meals.rawValue)
    }
    
    private static func getDb(bucket: String) -> DatabaseReference {
        let db = Database.database().reference().child(bucket)
        return db
    }
}
