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
        
        setDateSelected(meal.date)
        setTimeSelected(meal.time)
        
        mealOptionView.ui.noteTextView.text = meal.note
    }}
    
    func setDateSelected(_ date: String?) {
        let dateView = mealOptionView.ui.dateView
        var dates = dateView.datasource
        var idxPath = IndexPath(row: 0, section: 0)
        
        for i in 0 ..< dates.count {
            let dateString = dates[i].date.toString("dd MMM yyyy")
            if dateString == date {
                dates[i].selected = true
                idxPath.row = i
                break
            }
        }
        if let index = dateView.selectedIndex, index != idxPath {
            dates[index.row].selected = false
        }
        run({
            if idxPath.row - 2 >= 0 {
                var newIp = idxPath
                newIp.row -= 2
                dateView.collectionView.scrollToItem(at: newIp, at: .left, animated: false)
            }
        }, after: 0.1)
        
        dateView.selectedIndex = idxPath
        dateView.datasource = dates
    }
    
    func setTimeSelected(_ time: String?) {
        let timeView = mealOptionView.ui.timeView
        var times = mealOptionView.ui.getTimeSlots().map({ return knTime(time: $0) })
        var idxPath = IndexPath.zero
        for i in 0 ..< times.count {
            if times[i].time == time {
                idxPath.row = i
                times[i].selected = true
                break
            }
        }
        timeView.datasource = times
        timeView.selectedIndex = idxPath
        run({
            if idxPath.row - 2 >= 0 {
                var newIp = idxPath
                newIp.row -= 2
                timeView.collectionView.scrollToItem(at: newIp, at: .left, animated: false)
            }
            timeView.didSelectItem(at: idxPath)
        }, after: 0.1)
    }
    
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
