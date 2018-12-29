//
//  Register.UI.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/20/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit

extension CTRegisterCtr {
    class UI: NSObject {
        let padding: CGFloat = 32
        let nameTextField = UIMaker.makeTextField(placeholder: "Full Name",
                                                   icon: UIImage(named: "profile"))
        let emailTextField = UIMaker.makeTextField(placeholder: "Email",
                                                   icon: UIImage(named: "email"))
        let passwordTextField = UIMaker.makeTextField(placeholder: "Password",
                                                      icon: UIImage(named: "password"))
        let registerButton = UIMaker.makeMainButton(title: "CREATE ACCOUNT ")
        lazy var signinButton = makeSigninButton()
        private var revealButton: UIButton!
        private func makeSigninButton() -> UIButton {
            let strongText = "Sign In"
            let button = UIMaker.makeButton(title: "Already have an account? \(strongText)",
                                            titleColor: UIColor.CT_163_169_175,
                                            font: UIFont.main(size: 13))
            button.titleLabel?.formatText(boldStrings: [strongText],
                                          boldFont: UIFont.main(size: 13),
                                          boldColor: UIColor.CT_25)
            button.titleLabel?.underline(string: strongText)
            return button
        }
        lazy var termLabel: knTermLabel = {
            let label = knTermLabel()
            let font = UIFont.main(size: 11)
            let color = UIColor.CT_163_169_175
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
        
        @objc private  func viewTerm() {
            openUrlInSafari("https://toptal.com")
        }
        
        private func makeCell(tf: UITextField) -> knTableCell {
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
            passwordTextField.isSecureTextEntry = true
            passwordTextField.returnKeyType = .next
            
            nameTextField.autocorrectionType = .no
            nameTextField.autocapitalizationType = .words
            nameTextField.returnKeyType = .next
            
            revealButton = passwordTextField.setView(.right,
                                                     image: UIImage(named: "show_pass_inactive") ?? UIImage())
            revealButton.addTarget(self, action: #selector(showPassword))
            
            return [
                makeCell(tf: nameTextField),
                makeCell(tf: emailTextField),
                makeCell(tf: passwordTextField)
            ]
        }
        
        @objc private func showPassword() {
            passwordTextField.toggleSecure()
            let image = passwordTextField.isSecureTextEntry ? UIImage(named: "show_pass_inactive") : UIImage(named: "show_pass_active")
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

