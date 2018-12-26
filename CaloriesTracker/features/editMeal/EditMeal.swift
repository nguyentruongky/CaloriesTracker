//
//  EditMeal.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/26/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit

class CTEditMealCtr: CTAddMealCtr {
    var meal: CTMeal? { didSet {
        guard let meal = meal else { return }
        mealOptionView.meal = meal
        let calories = meal.calories ?? appSetting.standardCalories
        mealOptionView.ui.caloriesAmountLabel.text = String(calories)
        mealOptionView.ui.caloriesSlider.value = Float(calories)
        
        let dates = mealOptionView.ui.dateView.datasource
        var dateIndexPath = IndexPath(row: 0, section: 0)

        for i in 0 ..< dates.count {
            let dateString = dates[i].date.toString("dd MMM yyyy")
            if dateString == meal.date {
                dateIndexPath.row = i
                break
            }
        }
        
        mealOptionView.ui.dateView.selectedIndex = dateIndexPath
        mealOptionView.ui.dateView.didSelectItem(at: dateIndexPath)
        
        let times = mealOptionView.ui.getTimeSlots()
        var timeIndexPath = IndexPath(row: 0, section: 0)
        for i in 0 ..< times.count {
            if times[i] == meal.time {
                timeIndexPath.row = i
                break
            }
        }
        
        mealOptionView.ui.timeView.didSelectItem(at: timeIndexPath)
        mealOptionView.ui.noteTextView.text = meal.note
    }}
    
    override func setupView() {
        super.setupView()
        title = "EDIT MEAL"
        checkoutButton.badgeValue = String(meal?.foods.count ?? 0)
    }
    
    override func showCheckout() {
        mealOptionView.saveMeal()
        let ctr = CTCheckoutEditCtr()
        ctr.meal = mealOptionView.meal
        ctr.addMealCtr = self
        present(wrap(ctr))
    }
    
    
}
