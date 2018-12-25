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
        ui.thisWeekView.datasource = meals
        tableView.setHeader(ui.makeHeaderView(), height: headerHeight)
    }
    
    func didGetUpcomingMealsFail(_ err: knError) {
        
    }
    
    func didGetPreviousMeals(_ meals: [CTMeal]) {
        datasource = meals
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
            CTGetUpcomingMealsWorker(successAction: output?.didGetPreviousMeals,
                                     failAction: output?.didGetPreviousMealsFail).execute()
        }
        
        private weak var output: Controller?
        init(controller: Controller) { output = controller }
    }
    typealias Controller = CTMealsDashboard
}
