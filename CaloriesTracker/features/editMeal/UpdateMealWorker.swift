//
//  UpdateMealWorker.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/26/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

struct CTUpdateMealWorker {
    private var meal: CTMeal
    var successAction: (() -> Void)?
    var failAction: ((knError) -> Void)?
    init(meal: CTMeal, successAction: (() -> Void)?, failAction: ((knError) -> Void)?) {
        self.meal = meal
        self.successAction = successAction
        self.failAction = failAction
    }
    
    func execute() {
        guard let userId = appSetting.userId,
            let ownerId = meal.ownerId,
            let mealId = meal.id else { return }
        var hasPermission = true
        if userId != ownerId && appSetting.userRole != .admin {
            hasPermission = false
        }
        
        if hasPermission == false {
            failAction?(knError(code: "forbidden", message: "You don't have permission to change this"))
            return
        }
        
        let foods = meal.foods.map({ return $0.toDict() })
        let data = [
            "meal_id": mealId,
            "user_id": ownerId,
            "foods": foods,
            "time": meal.time,
            "date": meal.date,
            "calories": meal.calories,
            "note": meal.note
            ] as [String : Any?]
        let bucket = CTDataBucket.meals.rawValue
        let ref = Database.database().reference().child(bucket)
        ref.child(mealId).setValue(data)
        successAction?()
    }
}
