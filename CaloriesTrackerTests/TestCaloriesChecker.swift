//
//  TestCaloriesChecker.swift
//  CaloriesTrackerTests
//
//  Created by Ky Nguyen Coinhako on 1/1/19.
//  Copyright © 2019 Ky Nguyen. All rights reserved.
//

import XCTest
import Firebase
@testable import CaloriesTracker

class CaloriesCheckerTests: XCTestCase {
    
    func testCheckStandard() {
        let meals = [
            CTMeal(calories: 800, date: "20 Dec 2018"),
            CTMeal(calories: 1000, date: "20 Dec 2018"),
            CTMeal(calories: 1200, date: "20 Dec 2018"),
            CTMeal(calories: 1200, date: "21 Dec 2018"),
        ]
        let standard = 2000
        let grouppedMeals = Dictionary(grouping: meals, by: { return $0.date })
        for (_, values) in grouppedMeals {
            let totalCalories = values.reduce(0) { (totalCalories, meal) -> Int in
                return totalCalories + meal.calories.or(0)
            }
            for item in values {
                item.isStandard = totalCalories <= standard
            }
        }
        
        XCTAssertTrue(meals[0].isStandard == false)
        XCTAssertTrue(meals[3].isStandard == true)
    }
}

extension CTMeal {
    convenience init(calories: Int, date: String) {
        self.init()
        self.date = date
        self.calories = calories
    }
}
