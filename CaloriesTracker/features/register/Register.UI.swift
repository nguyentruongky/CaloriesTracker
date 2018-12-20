//
//  Register.UI.swift
//  SnapShop
//
//  Created by Ky Nguyen Coinhako on 10/30/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit

extension snRegisterCtr {
    class UI: NSObject {
        let padding: CGFloat = 32
        let firstNameTextField = UIMaker.makeTextField(placeholder: "First Name",
                                                   icon: UIImage(named: "profile"))
        let lastNameTextField = UIMaker.makeTextField(placeholder: "Last Name",
                                                   icon: UIImage(named: "profile"))
        let emailTextField = UIMaker.makeTextField(placeholder: "Email",
                                                   icon: UIImage(named: "email"))
        let passwordTextField = UIMaker.makeTextField(placeholder: "Password",
                                                      icon: UIImage(named: "password"))
        let registerButton = UIMaker.makeMainButton(title: "CREATE ACCOUNT ")
        lazy var signinButton = makeSigninButton()
        var revealButton: UIButton!
        func makeSigninButton() -> UIButton {
            let strongText = "Sign In"
            let button = UIMaker.makeButton(title: "Already have an account? \(strongText)",
                                            titleColor: UIColor.s_163_169_175,
                                            font: UIFont.main(size: 13))
            button.titleLabel?.formatText(boldStrings: [strongText],
                                          boldFont: UIFont.main(size: 13),
                                          boldColor: UIColor.s_19)
            button.titleLabel?.underline(string: strongText)
            return button
        }
        lazy var termLabel: knTermLabel = {
            let label = knTermLabel()
            let font = UIFont.main(size: 11)
            let color = UIColor.s_163_169_175
            let strongText = "Terms and Conditions."
            label.formatText(fullText: "By signing up you agree with our \(strongText)",
                             boldTexts: [strongText],
                             boldFont: font, boldColor: color,
                             font: font, color: color,
                             alignment: .center, lineSpacing: 7,
                             actions: [{ [weak self] in self?.viewTerm()} ])
            label.underline(string: strongText)
            return label
        }()
        
        @objc func viewTerm() {
            
        }
        
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
            emailTextField.returnKeyType = .next
            
            passwordTextField.isSecureTextEntry = true
            passwordTextField.returnKeyType = .next
            
            firstNameTextField.autocapitalizationType = .words
            firstNameTextField.returnKeyType = .next
            
            lastNameTextField.autocapitalizationType = .words
            lastNameTextField.returnKeyType = .next
            
            revealButton = passwordTextField.setView(.right,
                                                     image: UIImage(named: "show_pass_inactive") ?? UIImage())
            revealButton.addTarget(self, action: #selector(showPassword))
            
            return [
                makeCell(tf: firstNameTextField),
                makeCell(tf: lastNameTextField),
                makeCell(tf: emailTextField),
                makeCell(tf: passwordTextField)
            ]
        }
        
        @objc func showPassword() {
            passwordTextField.toggleSecure()
            let image = passwordTextField.isSecureTextEntry ? UIImage(named: "show_pass_active") : UIImage(named: "show_pass_inactive")
            revealButton.setImage(image, for: .normal)
        }
        
        func makeFooter() -> UIView {
            let view = UIMaker.makeView()
            view.addSubviews(views: registerButton, signinButton, termLabel)
            view.addConstraints(withFormat: "V:|-38-[v0]-25-[v1]-16-[v2]",
                                views: registerButton, signinButton, termLabel)
            registerButton.horizontal(toView: view, space: padding)
            signinButton.centerX(toView: view)
            termLabel.horizontal(toView: view)
            return view
        }
    }
}

