//
//  AddUser.Interactor.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/27/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit

extension CTAddUserCtr {
    func didCreate() {
        ui.createButton.setProcess(visible: false)
        CTMessage.showMessage("Account created")
        pop()
    }
    
    func didCreateFail(err: knError) {
        ui.createButton.setProcess(visible: false)
        CTMessage.showError(err.message ?? "Can't creat account with email \(ui.emailTextField.text!)")
    }
    
}

extension CTAddUserCtr {
    class Interactor {
        func createAccount(email: String, password: String, name: String) {
            CTCreateUserWorker(email: email,
                               password: password,
                               name: name,
                               success: output?.didCreate,
                               fail: output?.didCreateFail).execute()
        }
        
        private weak var output: Controller?
        init(controller: Controller) { output = controller }
    }
    typealias Controller = CTAddUserCtr
}
