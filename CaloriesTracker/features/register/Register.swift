//
//  Register.swift
//  SnapShop
//
//  Created by Ky Nguyen Coinhako on 10/30/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit

class snRegisterCtr: knStaticListController {
    lazy var output = Interactor(controller: self)
    let validation = Validation()
    let ui = UI()
    
    override func setupView() {
        title = "JOIN SNAPSHOP"
        let closeButton = UIBarButtonItem(image: UIImage(named: "close"),
                                          style: .done, target: self, action: #selector(close))
        hideNavBar(false)
        navigationItem.leftBarButtonItem = closeButton
        super.setupView()
        datasource = ui.setupView()
        tableView.setFooter(ui.makeFooter(), height: 200)
        view.addSubviews(views: tableView)
        tableView.fill(toView: view, space: UIEdgeInsets(top: 60))
        
        ui.registerButton.addTarget(self, action: #selector(register))
        ui.signinButton.addTarget(self, action: #selector(showSignin))
        ui.firstNameTextField.delegate = self
        ui.lastNameTextField.delegate = self
        ui.emailTextField.delegate = self
        ui.passwordTextField.delegate = self
    }
    
    @objc func register() {
        hideKeyboard()
        validation.firstName = ui.firstNameTextField.text
        validation.lastName = ui.lastNameTextField.text
        validation.email = ui.emailTextField.text
        validation.password = ui.passwordTextField.text
        let (result, error) = validation.validate()
        if result == false {
            snMessage.showError(error ?? "", inSeconds: 5)
            return
        }
        ui.registerButton.setProcess(visible: true)
        output.register(validation: validation)
    }
    
    @objc func showSignin() {
        hideNavBar(true)
        setControllers([snLoginCtr()])
    }
    
    @objc func close() { dismiss() }
}

extension snRegisterCtr: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let isFirstNameEmpty = ui.firstNameTextField.text?.isEmpty == true
        let isLastNameEmpty = ui.lastNameTextField.text?.isEmpty == true
        let isEmailEmpty = ui.emailTextField.text?.isEmpty == true
        let isPasswordEmpty = ui.passwordTextField.text?.isEmpty == true
        
        if !isFirstNameEmpty && !isLastNameEmpty && !isEmailEmpty && !isPasswordEmpty {
            register()
            return true
        }
        
        if textField == ui.firstNameTextField {
            ui.lastNameTextField.becomeFirstResponder()
        } else if textField == ui.lastNameTextField {
            ui.emailTextField.becomeFirstResponder()
        } else if textField == ui.emailTextField {
            ui.passwordTextField.becomeFirstResponder()
        } else if textField == ui.passwordTextField {
            register()
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
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
