//
//  GetFoodsWorker.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/24/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct CTGetFoodsWorker {
    private var page = 1
    private let MAX_ITEM: UInt = 6
    private var successAction: (([CTFood]) -> Void)?
    private var failAction: ((knError) -> Void)?
    
    init(page: Int,
         successAction: (([CTFood]) -> Void)?,
         failAction: ((knError) -> Void)?) {
        self.page = page
        self.successAction = successAction
        self.failAction = failAction
    }
    
    func execute() {
        let bucket = CTDataBucket.foods.rawValue
        let ref = Database.database().reference().child(bucket)
        let query = ref.queryLimited(toFirst: UInt(page) * MAX_ITEM)
        
        query.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let raws = snapshot.value as? [String: AnyObject] else {
                let error = knError(code: "no_data")
                self.failAction?(error)
                return
            }
            
            let foods = Array(raws.values).map({ return CTFood(raw: $0) })
            self.successAction?(foods)
            
        }) { (err) in
            let error = knError(code: "no_data", message: err.localizedDescription)
            self.failAction?(error)
        }
    }
}
