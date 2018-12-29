//
//  AddMealWorker.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/25/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import Foundation

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
        guard let userId = appSetting.userId else { return }
        let foods = meal.foods.map({ return $0.toDict() })
        let mealId = UUID().uuidString
        let data = [
            "meal_id": mealId,
            "user_id": userId,
            "foods": foods,
            "time": meal.time,
            "date": meal.date,
            "calories": meal.calories,
            "note": meal.note
        ] as [String : Any?]
        
        let db = CTDataBucket.getMealDb()
        db.child(mealId).setValue(data)
        successAction?()
    }
}
