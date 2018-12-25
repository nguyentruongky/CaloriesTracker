//
//  GetFoodDetailWorker.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/26/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct CTGetFoodDetailWorker {
    private var id: Int
    private var successAction: ((CTFood) -> Void)?
    private var failAction: ((knError) -> Void)?
    init(id: Int,
         successAction: ((CTFood) -> Void)?,
         failAction: ((knError) -> Void)?) {
        self.id = id
        self.successAction = successAction
        self.failAction = failAction
    }
    
    func execute() {
        let bucket = CTDataBucket.foods.rawValue
        let ref = Database.database().reference().child(bucket)
        ref.queryOrdered(byChild: "id").queryEqual(toValue: id).observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot)
            
        }) { (err) in
            let error = knError(code: "no_data", message: err.localizedDescription)
            self.failAction?(error)
        }

    }
}
