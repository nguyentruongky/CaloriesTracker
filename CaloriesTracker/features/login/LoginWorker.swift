//
//  LoginWorker.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/20/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import Foundation

class CTUser {
    var email: String?
    var token: String?
    var name: String?
    var userId: String?
    var avatar: String?
    var cover: String?
    var phone: String?
    
    init() { }
    init(name: String, avatar: String) {
        self.name = name
        self.avatar = avatar
    }
}

struct snLoginWorker {
    private let api = "/users/login/"
    var email: String
    var password: String
    var success: ((CTUser) -> Void)?
    var fail: ((knError) -> Void)?
    
    init(email: String, password: String,
         success: ((CTUser) -> Void)?,
         fail: ((knError) -> Void)?) {
        self.email = email
        self.password = password
        self.fail = fail
        self.success = success
    }
    
    func execute() {
        
    }
    
    private func successResponse(returnData: AnyObject) {
        
    }
    
    private func failResponse(err: knError) {
        fail?(err)
    }
}
