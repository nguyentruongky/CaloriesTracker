//
//  UserProfile.Interactor.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/27/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit

extension CTUserProfileCtr {
    func didGetMeals(_ meals: [CTMeal]) {
        ui.mealCountTextField.text = String(meals.count)
        setupEmptyView(visible: meals.isEmpty)
        datasource = meals
    }
    
    func didGetMealsFail(_ err: knError) {
        setupEmptyView(visible: true)
    }
}

extension CTUserProfileCtr {
    class Interactor {
        func getMeals(userId: String) {
            CTGetAllMealsWorker(userId: userId, successAction: output?.didGetMeals,
                                failAction: output?.didGetMealsFail).execute()
        }
        
        private weak var output: Controller?
        init(controller: Controller) { output = controller }
    }
    typealias Controller = CTUserProfileCtr
}
