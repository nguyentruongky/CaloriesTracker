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
        recheckCalories()
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
        showState(.error)
        CTMessage.showError(err.message ?? "Server error")
    }
    
    func didGetPreviousMeals(_ meals: [CTMeal]) {
        datasource = meals
        didLoadPreviousMeals = true
        checkData()
    }
    
    func didGetPreviousMealsFail(_ err: knError) {
        showState(.error)
        CTMessage.showError(err.message ?? "Server error")
    }
    
    func showState(_ state: knState) {
        ui.stateView.state = state
    }
}

extension CTMealsDashboard {
    class Interactor {
        let PERSISTENT_TIME: Double = 30
        private var lastUpdated = Date()
        var needUpdate: Bool {
            return Date().timeIntervalSince(lastUpdated) > PERSISTENT_TIME
        }
        func getUpcomingMeals() {
            if hasConnection() == false { return }
            CTGetUpcomingMealsWorker(successAction: didGetUpcomingMeals,
                                     failAction: output?.didGetUpcomingMealsFail).execute()
        }
        
        func didGetUpcomingMeals(_ meals: [CTMeal]) {
            output?.didGetUpcomingMeals(meals)
            lastUpdated = Date()
        }
        
        func hasConnection() -> Bool {
            if Reachability.isConnected == false {
                output?.showState(.noInternet)
                return false
            }
            output?.showState(.loading)
            return true
        }
        func getPreviousMeals() {
            if hasConnection() == false { return }
            CTGetPreviousMealsWorker(successAction: didGetPreviousMeals,
                                     failAction: output?.didGetPreviousMealsFail).execute()
        }
        
        func didGetPreviousMeals(_ meals: [CTMeal]) {
            output?.didGetPreviousMeals(meals)
            lastUpdated = Date()
        }
        
        private weak var output: Controller?
        init(controller: Controller) { output = controller }
    }
    typealias Controller = CTMealsDashboard
}
