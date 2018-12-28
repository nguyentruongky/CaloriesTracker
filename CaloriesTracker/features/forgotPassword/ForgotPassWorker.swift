//
//  ForgotPassWorker.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/29/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import Foundation
import FirebaseAuth

struct CTForgotPassWorker {
    private var email: String
    private var successAction: ((String) -> Void)?
    private var failAction: ((knError) -> Void)?
    
    init(email: String,
         successAction: ((String) -> Void)?,
         failAction: ((knError) -> Void)?) {
        self.email = email
        self.successAction = successAction
        self.failAction = failAction
    }
    
    func execute() {
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if let error = error {
                self.failAction?(knError(code: "reset_fail", message: error.localizedDescription))
                return
            }
            
            self.successAction?("Check your inbox and follow the instruction")
        }
    }
}
