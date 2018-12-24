//
//  PasswordValidation.swift
//  SnapShop
//
//  Created by Ky Nguyen Coinhako on 11/17/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import Foundation

struct CTPasswordValidation {
    func checkCharCount(_ password: String) -> Bool {
        let regexCharCount = "^.{6,}$"
        let passwordTest1 = NSPredicate(format: "SELF MATCHES %@", regexCharCount)
        return passwordTest1.evaluate(with: password)
    }
}
