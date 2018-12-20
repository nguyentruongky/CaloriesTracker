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
        title = "Sign in"
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
    func textFieldDidBeginEditing(_ textField: UITextField) {
        tableView.isScrollEnabled = false
        let bottomOffset = CGPoint(x: 0, y: 340)
        tableView.setContentOffset(bottomOffset, animated: true)
        run({ [weak self] in self?.tableView.isScrollEnabled = true }, after: 1)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == ui.emailTextField {
            ui.passwordTextField.becomeFirstResponder()
        } else {
            login()
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == ui.emailTextField {
            if ui.emailTextField.text?.isValidEmail() == true {
                textField.setView(.right, image: UIImage(named: "checked") ?? UIImage())
            } else {
                textField.rightView = nil
            }
        }
    }
}
