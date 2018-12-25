//
//  Meal.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/21/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import Foundation

class CTMeal {
    var id: String?
    var images = [String]()
    var name: String?
    var ingredient: String?
    var calorie: Int?
    var date: String?
    var time: String?
    var note: String?
    var foods = [CTFood]()
    var interval: TimeInterval? {
        guard let date = date, let time = time else { return nil }
        let string = date + " - " + time
        let realDate = Date(dateString: string, format: "dd MMM yyyy - hh:mm")
        return realDate.timeIntervalSince1970
    }
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
    
    init(raw: AnyObject) {
        id = raw["meal_id"] as? String
        calorie = raw["calories"] as? Int ?? 0
        date = raw["date"] as? String
        time = raw["time"] as? String
        
        if let foodsRaw = raw["foods"] as? [AnyObject] {
            foods = foodsRaw.map({ return CTFood(raw: $0) })
            self.images = foods.compactMap({ return $0.image })
        }
        name = foods.first?.name
        note = raw["note"] as? String
    }
    
}
