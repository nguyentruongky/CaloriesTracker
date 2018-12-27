//
//  AddUser.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/27/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit
class CTAddUserCtr: knStaticListController {
    let ui = UI()
    lazy var output = Interactor(controller: self)
    
    override func setupView() {
        title = "CREATE NEW ACCOUNT"
        addBackButton(tintColor: .CT_25)
        navigationController?.hideBar(false)
        contentInset = UIEdgeInsets(top: padding)
        super.setupView()
        datasource = ui.setupView()
        view.addSubviews(views: tableView)
        tableView.fill(toView: view)
        
        ui.createButton.addTarget(self, action: #selector(createAccount))
        ui.nameTextField.delegate = self
        ui.emailTextField.delegate = self
        ui.passwordTextField.delegate = self
        
        ui.nameTextField.becomeFirstResponder()
    }
    
    @objc func createAccount() {
        ui.createButton.setProcess(visible: true)
        output.createAccount(email: ui.emailTextField.text!,
                             password: ui.passwordTextField.text!,
                             name: ui.nameTextField.text!)
    }
}

extension CTAddUserCtr: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let isNameEmpty = ui.nameTextField.text?.isEmpty == true
        let isEmailEmpty = ui.emailTextField.text?.isEmpty == true
        let isPasswordEmpty = ui.passwordTextField.text?.isEmpty == true
        
        if !isNameEmpty && !isEmailEmpty && !isPasswordEmpty {
            createAccount()
            return true
        }
        
        if textField == ui.nameTextField {
            ui.emailTextField.becomeFirstResponder()
        } else if textField == ui.emailTextField {
            ui.passwordTextField.becomeFirstResponder()
        } else if textField == ui.passwordTextField {
            createAccount()
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
