//
//  AddMeal.Interactor.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/24/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit

extension CTAddMealCtr {
    func didGetFoods(_ foods: [CTFood]) {
        stateView?.state = .success
        datasource = foods
    }
    
    func didGetMoreFoods(_ foods: [CTFood]) {
        datasource = foods
    }
    
    func didGetFoodsFail(_ err: knError) {
        stateView?.state = .error
    }
}

extension CTAddMealCtr {
    class Interactor {
        private var page = 1
        private var loading = false
        private var canGetMore = true
        func getFoods() {
            guard loading == false && canGetMore else { return }
            if Reachability.isConnected == false {
                output?.stateView?.state = .noInternet
            } else {
                output?.stateView?.state = .loading
            }
            loading = true
            CTGetFoodsWorker(page: page, successAction: didGetFoods,
                             failAction: output?.didGetFoodsFail).execute()
        }
        
        private func didGetFoods(_ foods: [CTFood]) {
            canGetMore = !foods.isEmpty
            page += foods.isEmpty == false ? 1 : 0
            loading = false
            output?.didGetFoods(foods)
        }
        
        func getMoreFoods() {
            guard loading == false && canGetMore else { return }
            loading = true
            CTGetFoodsWorker(page: page, successAction: didGetMoreFoods,
                             failAction: output?.didGetFoodsFail).execute()
        }
        
        private func didGetMoreFoods(_ foods: [CTFood]) {
            canGetMore = !foods.isEmpty
            page += foods.isEmpty == false ? 1 : 0
            loading = false
            output?.didGetMoreFoods(foods)
        }
        
        private weak var output: Controller?
        init(controller: Controller) { output = controller }
    }
    typealias Controller = CTAddMealCtr
}
