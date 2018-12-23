//
//  Meal.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/21/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import Foundation

enum CTMealType: String {
    case breakfast, lunch, dinner
}


struct CTMeal {
    var image: String?
    var name: String?
    var ingredient: String?
    var calorie: Int?
    var date: String?
    var mealType = CTMealType.breakfast
    
    init(image: String, name: String, ingredient: String, calory: Int, date: String, mealType: CTMealType) {
        self.image = image
        self.name = name
        self.ingredient = ingredient
        self.calorie = calory
        self.date = date
        self.mealType = mealType
    }
}
