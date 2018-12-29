//
//  ForgotPassword.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/29/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit

class CTForgotPassCtr: knStaticListController {
    let ui = UI()
    override func setupView() {
        navigationController?.hideBar(false)
        addBackButton(tintColor: UIColor.CT_25)
        title = "FORGOT PASSWORD"
        super.setupView()
        view.addFill(tableView)
        datasource = [ui.setupView()]
        ui.sendButton.addTarget(self, action: #selector(sendRequest))
        ui.emailTextField.delegate = self
    }
    
    @objc func sendRequest() {
        if ui.emailTextField.text?.isValidEmail() == false {
            CTMessage.showError("Invalid email")
            return
        }
        
        ui.sendButton.setProcess(visible: true)
        CTForgotPassWorker(email: ui.emailTextField.text!, successAction: didSend,
                           failAction: didSendFail).execute()
    }
}

extension CTForgotPassCtr: UITextFieldDelegate {
    func didSend(_ message: String) {
        ui.sendButton.setProcess(visible: false)
        CTMessage.showMessage(message)
        pop()
    }
    
    func didSendFail(_ err: knError) {
        CTMessage.showError(err.message ?? "Can't send your request")
        ui.sendButton.setProcess(visible: false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendRequest()
        return false
    }
}
