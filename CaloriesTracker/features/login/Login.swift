//
//  Login.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/20/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit

class CTLoginCtr: knStaticListController {
    let ui = UI()
    lazy var output = Interactor(controller: self)
    var validation = Validation()

    override func setupView() {
        super.setupView()
        title = "LOG IN"
        navigationController?.hideBar(false)
        view.addSubviews(views: tableView)
        tableView.fill(toView: view)
        datasource = ui.setupView()
        
        ui.registerButton.addTarget(self, action: #selector(showRegister))
        ui.forgotButton.addTarget(self, action: #selector(showForgot))
        ui.closeButton.addTarget(self, action: #selector(dismissScreen))
        ui.loginButton.addTarget(self, action: #selector(login))
        
        ui.emailTextField.delegate = self
        ui.passwordTextField.delegate = self
        ui.emailTextField.becomeFirstResponder()
    }
    
    @objc func dismissScreen() { dismiss() }
    
    @objc func showRegister(){
        navigationController?.setControllers([CTRegisterCtr()])
    }
    
    @objc func showForgot(){
//        let ctr = snForgotPassCtr()
//        ctr.ui.emailTextField.text = ui.emailTextField.text
//        push(ctr)
    }
    
    @objc func login() {
        hideKeyboard()
        validation.email = ui.emailTextField.text
        validation.password = ui.passwordTextField.text
        let (valid, message) = validation.validate()
        if valid == false {
            CTMessage.showError(message ?? "", inSeconds: 5)
            return
        }
        
        ui.loginButton.setProcess(visible: true)
        output.login(email: validation.email!, password: validation.password!)
    }
}

extension CTLoginCtr: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let isEmailEmpty = ui.emailTextField.text?.isEmpty == true
        let isPasswordEmpty = ui.passwordTextField.text?.isEmpty == true
        
        if !isEmailEmpty && !isPasswordEmpty {
            login()
            return true
        }
        
        if textField == ui.emailTextField {
            ui.passwordTextField.becomeFirstResponder()
        } else if textField == ui.passwordTextField {
            login()
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard textField != ui.passwordTextField else { return }
        
        var isValid = textField.text?.isEmpty == false
        if textField == ui.emailTextField {
            isValid = textField.text?.isValidEmail() == true
        }
        
        if isValid {
            textField.setView(.right, image: UIImage(named: "checked") ?? UIImage())
        } else {
            textField.rightView = nil
        }
    }
}
