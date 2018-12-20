//
//  RegisterWorker.swift
//  SnapShop
//
//  Created by Ky Nguyen Coinhako on 11/1/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import Foundation
struct snRegisterWorker: knWorker {
    private let api = "/users/register/"
    var firstName: String
    var lastName: String
    var email: String
    var password: String
    var success: ((snUser) -> Void)?
    var fail: ((knError) -> Void)?
    
    init(firstName: String, lastName: String,
         email: String, password: String,
         success: ((snUser) -> Void)?,
         fail: ((knError) -> Void)?) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.password = password
        self.fail = fail
        self.success = success
    }
    
    func execute() {
        let params = [
            "first_name": firstName,
            "last_name": lastName,
            "email": email,
            "password": password
        ]
        
        ServiceConnector.post(api, params: params,
                              success: successResponse,
                              fail: failResponse)
    }
    
    func successResponse(returnData: AnyObject) {
        guard let raw = returnData["user"] as AnyObject? else {
            let err = knError(code: "no_data", message: "No user data returned")
            failResponse(err: err)
            return
        }
        
        let user = snUser(raw: raw)
        user.token = returnData["token"] as? String
        success?(user)
    }
    
    func failResponse(err: knError) {
        var newErr = err
        if err.code == "409" {
            newErr.message = "Your email is registered. Please try another one"
        }
        fail?(newErr)
    }
}
