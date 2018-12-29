//
//  Meals.Interactor.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/26/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit

extension CTMealsDashboard {
    func didGetUpcomingMeals(_ meals: [CTMeal]) {
        upcomingMeals = meals
        didLoadUpcomingMeals = true
        checkData()
    }
    
    func checkData() {
        guard didLoadPreviousMeals && didLoadUpcomingMeals else { return }
        let isEmpty = upcomingMeals.isEmpty && datasource.isEmpty
        if isEmpty {
            ui.greetingView.backgroundColor = .white
            ui.stateView.state = .empty
        } else {
            ui.greetingView.backgroundColor = .bg
            ui.stateWrapper.removeFromSuperview()
            tableView.reloadData()
            ui.upcomingStack.layoutIfNeeded()
        }
    }
    
    func didGetUpcomingMealsFail(_ err: knError) {
        
    }
    
    func didGetPreviousMeals(_ meals: [CTMeal]) {
        datasource = meals
        didLoadPreviousMeals = true
        checkData()
    }
    
    func didGetPreviousMealsFail(_ err: knError) {
        
    }
}

extension CTMealsDashboard {
    class Interactor {
        func getUpcomingMeals() {
            CTGetUpcomingMealsWorker(successAction: output?.didGetUpcomingMeals,
                                     failAction: output?.didGetUpcomingMealsFail).execute()
        }
        
        func getPreviousMeals() {
            CTGetPreviousMealsWorker(successAction: output?.didGetPreviousMeals,
                                     failAction: output?.didGetPreviousMealsFail).execute()
        }
        
        private weak var output: Controller?
        init(controller: Controller) { output = controller }
    }
    typealias Controller = CTMealsDashboard
}
