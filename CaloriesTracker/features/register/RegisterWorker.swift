//
//  RegisterWorker.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/20/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import Foundation
struct snRegisterWorker {
    private let api = "/users/register/"
    var firstName: String
    var lastName: String
    var email: String
    var password: String
    var success: ((CTUser) -> Void)?
    var fail: ((knError) -> Void)?
    
    init(firstName: String, lastName: String,
         email: String, password: String,
         success: ((CTUser) -> Void)?,
         fail: ((knError) -> Void)?) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.password = password
        self.fail = fail
        self.success = success
    }
    
    func execute() {
        
    }
    
    func successResponse(returnData: AnyObject) {
        
    }
    
    func failResponse(err: knError) {
        
    }
}
