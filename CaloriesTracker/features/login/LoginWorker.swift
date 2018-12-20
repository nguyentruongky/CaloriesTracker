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
    var firstName: String?
    var lastName: String?
    var userId: Int?
    var avatar: String?
    var cover: String?
    var phone: String?
    
    init(raw: AnyObject) {
        email = raw["email"] as? String
        firstName = raw["first_name"] as? String
        lastName = raw["last_name"] as? String
        name = firstName.or("") + " " + lastName.or("")
        userId = raw["id"] as? Int
        
        phone = raw["phone"] as? String
        
        cover = raw["phone"] as? String
        
        let defaulCover = "https://images.unsplash.com/photo-1503513883989-25ef8b2f1a53?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=36eaafb958cd6787048415f4096b646f&auto=format&fit=crop&w=1700&q=80"
        cover = cover ?? defaulCover
        
        let defaultAvatar = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSV_ExqGjttR39hREvayDTIQarycXsSoGwFltGGT9_j6CfYmNPL"
        avatar = raw["photo"] as? String ?? defaultAvatar
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
