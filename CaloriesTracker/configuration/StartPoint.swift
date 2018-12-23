//
//  StartPoint.swift
//  knStore
//
//  Created by Ky Nguyen Coinhako on 12/11/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit

class StartPoint {
    static var startingController: UIViewController {
        return CTBigBoss()
        let ctr = CTFoodDetailCtr()
        return wrap(ctr)
    }
}

