//
//  CaloriesChecker.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/26/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit

struct CaloriesTracker {
    func check(calories: Int) -> (bgColor: UIColor, textColor: UIColor, message: String) {
        if calories > appSetting.standardCalories {
            return (UIColor.red, UIColor.white, "High calories")
        } else {
            return (UIColor.green, UIColor.darkGray, "Standard")
        }
    }
}
