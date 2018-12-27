//
//  CheckoutEdit.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/26/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit

class CTCheckoutEditCtr: CTCheckoutCtr {
    override func setupView() {
        super.setupView()
        confirmButton.setTitle("Update")
    }
    
    override func confirmAddingMeal() {
        guard let meal = meal else { return }
        confirmButton.setProcess(visible: true)
        CTUpdateMealWorker(meal: meal, successAction: didUpdate,
                        failAction: didUpdateFail).execute()
    }
    
    func didUpdate() {
        CTMessage.showMessage("Meal updated")
        dismiss()
        addMealCtr?.pop()
        CTMealsDashboard.shouldUpdateUpcoming = true
        guard let controllers = addMealCtr?.navigationController?.viewControllers else { return }
        for ctr in controllers where ctr is CTMealDetailCtr {
            var meals = boss!.mealsCtr.datasource
            meals.append(contentsOf: boss!.mealsCtr.upcomingMeals)
            CaloriesTracker().checkCaloriesStandard(for: meals)
            (ctr as? CTMealDetailCtr)?.data = meal
        }
    }
    
    func didUpdateFail(_ err: knError) {
        CTMessage.showError(err.message ?? "Can't change your meal at this time. It's not your fault, it's ours")
    }
}
