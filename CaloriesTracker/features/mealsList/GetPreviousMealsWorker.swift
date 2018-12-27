//
//  GetMealsWorker.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/26/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

struct CTGetPreviousMealsWorker {
    private var successAction: (([CTMeal]) -> Void)?
    private var failAction: ((knError) -> Void)?
    
    init(successAction: (([CTMeal]) -> Void)?,
         failAction: ((knError) -> Void)?) {
        self.successAction = successAction
        self.failAction = failAction
    }
    
    func execute() {
        guard let userId = appSetting.userId else { return }
        let bucket = CTDataBucket.meals.rawValue
        let ref = Database.database().reference().child(bucket)
        ref.queryOrdered(byChild: "user_id").queryEqual(toValue: userId).observeSingleEvent(of: .value) { (snapshot) in
            self.mapRawData(snapshot.value)
        }
    }
    
    private func mapRawData(_ returnData: Any?) {
        guard let rawData = returnData as? [String: AnyObject] else {
            successAction?([])
            return
        }
        let values = Array(rawData.values)
        let meals = values.map({ return CTMeal(raw: $0) })
        CaloriesTracker().checkCaloriesStandard(for: meals)
        let now = Date().timeIntervalSince1970
        var previousMeals = meals.filter({ return ($0.interval) ?? 0 < now })
        previousMeals.sort(by: { return ($0.interval ?? 0) > ($1.interval ?? 0) })
        successAction?(previousMeals)
    }
    
}
