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
    private var successAction: (() -> Void)?
    private var failAction: ((knError) -> Void)?
    init(successAction: (() -> Void)?, failAction: ((knError) -> Void)?) {
        self.successAction = successAction
        self.failAction = failAction
    }
    
    func execute() {
        do {
            try Auth.auth().signOut()
            successAction?()
        } catch {
            let err = knError(code: "logout_fail", message: error.localizedDescription)
            failAction?(err)
        }
    }
}
