//
//  FilterWorker.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/27/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import Foundation
struct CTFilterWorker {
    var options: CTFilterOptions
    private var successAction: (([CTMeal]) -> Void)?
    private var failAction: ((knError) -> Void)?
    init(options: CTFilterOptions,
         successAction: (([CTMeal]) -> Void)?,
         failAction: ((knError) -> Void)?) {
        self.options = options
        self.successAction = successAction
        self.failAction = failAction
    }
    
    func execute() {
        let db = Helper.getMealDb()
        guard let userId = appSetting.userId else { return }
        db.queryOrdered(byChild: "user_id")
            .queryEqual(toValue: userId).observeSingleEvent(of: .value) { (snapshot) in
                guard let raws = snapshot.value as? [String: AnyObject] else { return }
                let meals = Array(raws.values).map({ return CTMeal(raw: $0) })
                var filterMeal = meals

                if let from = self.options.fromDate?.timeIntervalSince1970 {
                   filterMeal = filterMeal.filter({ ($0.interval ?? 0) > from })
                }
                
                if let to = self.options.toDate?.timeIntervalSince1970 {
                    filterMeal = filterMeal.filter({ ($0.interval ?? 0) < to })
                }
                
                let regimens = self.options.regimens
                if regimens.isEmpty == false {
                    filterMeal = filterMeal.filter({ regimens.contains($0.getMealTypeString()) })
                }
                
                self.successAction?(filterMeal)
        }
    }
}

