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
    var ownerId: String?
    var images = [String]()
    var name: String?
    var ingredient: String?
    var calories: Int?
    var date: String?
    var time: String?
    var note: String?
    var isStandard = true
    var foods = [CTFood]()
    var interval: TimeInterval {
        guard let date = date, let time = time else { return 0 }
        var string = date + " - " + time
        var format = "dd MMM yyyy - hh:mm"
        if time.starts(with: "12") {
            format = "dd MMM yyyy - hh:mm a"
            string = date + " - " + time + " pm"
        }
        let realDate = Date(dateString: string, format: format)
        return realDate.timeIntervalSince1970
    }
    var mealType: CTMealType {
        guard let time = time else { return .breakfast }
        guard let hourRaw = time.splitString(":").first, let hour = Int(hourRaw)
            else { return .breakfast }
        if hour >= 4 && hour < 10 { return .breakfast }
        if hour >= 10 && hour < 15 { return .lunch }
        if hour >= 15 && hour < 21 { return .dinner }
        return .collation
    }
    
    func getMealTypeString() -> String {
        let type = mealType.rawValue
        return type.capitalized
    }
    
    init() { }
    
    init(raw: AnyObject) {
        id = raw["meal_id"] as? String
        calories = raw["calories"] as? Int ?? 0
        date = raw["date"] as? String
        time = raw["time"] as? String
        
        if let foodsRaw = raw["foods"] as? [AnyObject] {
            foods = foodsRaw.map({ return CTFood(raw: $0) })
            self.images = foods.compactMap({ return $0.image })
        }
        name = foods.first?.name
        note = raw["note"] as? String
        ownerId = raw["user_id"] as? String
    }
    
}
