//
//  AddUser.UI.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/27/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit

extension CTAddUserCtr {
    class UI {
        let padding: CGFloat = 32
        let nameTextField = UIMaker.makeTextField(placeholder: "Full Name",
                                                  icon: UIImage(named: "profile"))
        let emailTextField = UIMaker.makeTextField(placeholder: "Email",
                                                   icon: UIImage(named: "email"))
        let passwordTextField = UIMaker.makeTextField(placeholder: "Password",
                                                      icon: UIImage(named: "password"))
        let createButton = UIMaker.makeMainButton(title: "CREATE ACCOUNT")
        
        func makeCell(tf: UITextField) -> knTableCell {
            let cell = knTableCell()
            cell.addSubviews(views: tf)
            tf.fill(toView: cell, space: UIEdgeInsets(left: padding, bottom: 16, right: padding))
            tf.height(50)
            return cell
        }
        
        func setupView() -> [knTableCell] {
            emailTextField.keyboardType = .emailAddress
            emailTextField.autocapitalizationType = .none
            emailTextField.autocorrectionType = .no
            emailTextField.returnKeyType = .next
            
            passwordTextField.autocorrectionType = .no
            passwordTextField.returnKeyType = .next
            
            nameTextField.autocorrectionType = .no
            nameTextField.autocapitalizationType = .words
            nameTextField.returnKeyType = .next
            
            let buttonCell = knTableCell()
            buttonCell.addSubview(createButton)
            createButton.fill(toView: buttonCell, space: UIEdgeInsets(space: padding))
            return [
                makeCell(tf: nameTextField),
                makeCell(tf: emailTextField),
                makeCell(tf: passwordTextField),
                buttonCell
            ]
        }
    }
}

