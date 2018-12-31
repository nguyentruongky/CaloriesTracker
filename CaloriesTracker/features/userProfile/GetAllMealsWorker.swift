//
//  GetAllMealsWorker.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/27/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import Foundation
struct CTGetAllMealsWorker {
    var userId: String
    private var successAction: (([CTMeal]) -> Void)?
    private var failAction: ((knError) -> Void)?
    init(userId: String, successAction: (([CTMeal]) -> Void)?, failAction: ((knError) -> Void)?) {
        self.userId = userId
        self.successAction = successAction
        self.failAction = failAction
    }
    
    func execute() {
        let db = CTDataBucket.getMealDb()
        db.queryOrdered(byChild: "user_id")
            .queryEqual(toValue: userId)
            .observeSingleEvent(of: .value) { (snapshot) in
                guard let rawData = snapshot.value as? [String: AnyObject] else {
                    self.successAction?([])
                    return
                }
                
                var meals = Array(rawData.values).map({ return CTMeal(raw: $0) })
                meals.sort(by: { return $0.interval < $1.interval })
                CaloriesChecker().checkCaloriesStandard(for: meals,
                                                        standard: appSetting.standardCalories)
                self.successAction?(meals)
        }
    }
}

