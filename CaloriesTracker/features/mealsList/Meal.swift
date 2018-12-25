//
//  Meal.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/21/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import Foundation

struct CTMeal {
    var image: String?
    var name: String?
    var ingredient: String?
    var calorie: Int?
    var date: String?
    var time: String?
    var note: String?
    var foods = [CTFood]()
    var mealType: CTMealType {
        guard let time = time else { return .breakfast }
        guard let hourRaw = time.splitString(":").first, let hour = Int(hourRaw)
            else { return .breakfast }
        if hour > 4 && hour < 10 { return .breakfast }
        if hour > 10 && hour < 14 { return .lunch }
        if hour > 14 && hour < 21 { return .dinner }
        return .midnight_snack
    }
    
    func getMealTypeString() -> String {
        let type = mealType.rawValue
        if mealType == .midnight_snack { return "Midnight Snack" }
        return type.capitalized
    }
    
    init() { }
    
    init(image: String, name: String, ingredient: String, calory: Int, date: String, mealType: CTMealType) {
        self.image = image
        self.name = name
        self.ingredient = ingredient
        self.calorie = calory
        self.date = date
    }
    
}
