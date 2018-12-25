//
//  AddMealWorker.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/25/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

struct CTAddMealWorker {
    private var meal: CTMeal
    var successAction: (() -> Void)?
    var failAction: ((knError) -> Void)?
    init(meal: CTMeal, successAction: (() -> Void)?, failAction: ((knError) -> Void)?) {
        self.meal = meal
        self.successAction = successAction
        self.failAction = failAction
    }
    
    func execute() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let foods = meal.foods.map({ return $0.toDict() })
        let mealId = UUID().uuidString
        let data = [
            "meal_id": mealId,
            "user_id": userId,
            "foods": foods,
            "time": meal.time,
            "date": meal.date,
            "calories": meal.calorie,
            "note": meal.note
        ] as [String : Any?]
        let bucket = CTDataBucket.meals.rawValue
        let ref = Database.database().reference().child(bucket)
        ref.child(mealId).setValue(data)
        successAction?()
    }
}
