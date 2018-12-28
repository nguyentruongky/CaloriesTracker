//
//  ForgotPassword.UI.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/29/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit

extension CTForgotPassCtr {
    class UI {
        let emailTextField = UIMaker.makeTextField(placeholder: "Email",
                                                   icon: UIImage(named: "email"))
        let sendButton = UIMaker.makeMainButton(title: "SEND RESET LINK")
        func setupView() -> knTableCell {
            emailTextField.autocorrectionType = .no
            emailTextField.autocapitalizationType = .none
            
            let instruction = "Please provide your email address so we can send you the reset link"
            let label = UIMaker.makeLabel(text: instruction, font: UIFont.main(size: 14),
                                          color: UIColor.CT_105,
                                          numberOfLines: 0, alignment: .center)
            let view = knTableCell()
            view.addSubviews(views: label, emailTextField, sendButton)
            view.addConstraints(withFormat: "V:|-32-[v0]-28-[v1]-32-[v2]-90-|",
                                views: label, emailTextField, sendButton)
            label.horizontal(toView: view, space: padding)
            emailTextField.horizontal(toView: view, space: padding)
            emailTextField.height(50)
            sendButton.horizontal(toView: emailTextField)
            
            return view
        }
    }
}

