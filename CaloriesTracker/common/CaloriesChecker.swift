//
//  CaloriesChecker.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/26/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit

struct CaloriesChecker {
    func getFormat(isStandard: Bool) -> (bgColor: UIColor, textColor: UIColor, message: String) {
        if isStandard {
            return (UIColor.green, UIColor.darkGray, "Standard")
        } else {
            return (UIColor.red, UIColor.white, "High calories")
        }
    }
    
    func checkCaloriesStandard(for meals: [CTMeal]) {
        let grouppedMeals = Dictionary(grouping: meals, by: { return $0.date })
        for (_, values) in grouppedMeals {
            let totalCalories = values.reduce(0) { (totalCalories, meal) -> Int in
                return totalCalories + meal.calories.or(0)
            }
            for item in values {
                item.isStandard = totalCalories <= appSetting.standardCalories
            }
        }
    }
}
