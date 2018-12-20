//
//  Login.Interactor.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/20/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit

extension CTLoginCtr {
    func didLogin(user: CTUser) {
        ui.loginButton.setProcess(visible: false)
        appSetting.user = user
        appSetting.token = user.token
        dismiss()
    }
    
    func didLoginFail(err: knError) {
        CTMessage.showError(err.message ?? "Login failed")
        ui.loginButton.setProcess(visible: false)
    }
    
}

extension CTLoginCtr {
    class Interactor {
        func login(email: String, password: String) {
            snLoginWorker(email: email, password: password,
                          success: output?.didLogin,
                          fail: output?.didLoginFail).execute()
        }
        
        private weak var output: Controller?
        init(controller: Controller) { output = controller }
    }
    typealias Controller = CTLoginCtr
}

extension CTLoginCtr {
    class Validation {
        var email: String?
        var password: String?
        func validate() -> (isValid: Bool, error: String?) {
            let emptyMessage = "%@ can't be empty"
            if email == nil || email?.isEmpty == true {
                return (false, String(format: emptyMessage, "Email")) }
            if password == nil || password?.isEmpty == true  {
                return (false, String(format: emptyMessage, "Password")) }
            
            if email?.isValidEmail() == false {
                return (false, "Invalid email or password") }
            
            return (true, nil)
        }
    }
}
