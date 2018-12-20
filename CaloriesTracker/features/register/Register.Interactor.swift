//
//  Register.Interactor.swift
//  SnapShop
//
//  Created by Ky Nguyen Coinhako on 11/1/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit

extension snRegisterCtr {
    func didRegister(user: snUser) {
        ui.registerButton.setProcess(visible: false)
        setting.user = user
        setting.token = user.token
        dismiss()
    }
    
    func didRegisterFail(_ err: knError) {
        ui.registerButton.setProcess(visible: false)
        snMessage.showError(err.message ?? "Can't register at this time", inSeconds: 5)
    }
}

extension snRegisterCtr {
    class Interactor {
        func register(validation: Validation) {
            snRegisterWorker(firstName: validation.firstName!,
                             lastName: validation.lastName!,
                             email: validation.email!,
                             password: validation.password!,
                             success: output?.didRegister,
                             fail: output?.didRegisterFail).execute()
        }
        
        private weak var output: Controller?
        init(controller: Controller) { output = controller }
    }
    typealias Controller = snRegisterCtr
}

extension snRegisterCtr {
    class Validation {
        var firstName: String?
        var lastName: String?
        var email: String?
        var password: String?
        func validate() -> (isValid: Bool, error: String?) {
            let emptyMessage = "%@ can't be empty"
            if firstName == nil || firstName?.isEmpty == true {
                return (false, String(format: emptyMessage, "First name")) }
            if lastName == nil || lastName?.isEmpty == true {
                return (false, String(format: emptyMessage, "Last name")) }
            if email == nil || email?.isEmpty == true {
                return (false, String(format: emptyMessage, "Email")) }
            if password == nil || password?.isEmpty == true  {
                return (false, String(format: emptyMessage, "Password")) }
            
            if email?.isValidEmail() == false {
                return (false, "Invalid email") }
            
            let passwordCheck = snPasswordValidation()
            if passwordCheck.checkCharCount(password!) == false {
                return (false, "Password has at least 8 characters") }
            if passwordCheck.checkUpperCase(password!) == false {
                return (false, "Password has at least 1 Uppercase character") }
            if passwordCheck.checkNumberDigit(password!) == false {
                return (false, "Password has at least 1 digit") }
            
            return (true, nil)
        }
    }
}
