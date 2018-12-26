//
//  LogoutWorker.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/26/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import Foundation
import FirebaseAuth

struct CTLogoutWorker {
    init() { }
    
    func execute() {
        try? Auth.auth().signOut()
    }
}
