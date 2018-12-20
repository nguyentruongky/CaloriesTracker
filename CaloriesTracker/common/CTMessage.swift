//
//  SNMessage.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/20/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit
class CTMessage {
    static func showMessage(_ message: String?, title: String?,
                            cancelActionName: String? = "OK") -> UIAlertController {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if cancelActionName != nil {
            controller.addAction(UIAlertAction(title: cancelActionName, style: .destructive, handler: nil))
        }
        return controller
    }
    
    @discardableResult
    static func showError(_ message: String, inSeconds seconds: Int = 5) -> Murmur {
        func hideMessage() { hide(whistleAfter: 0) }
        let murmur = Murmur(title: message, backgroundColor: UIColor.error,
                            titleColor: UIColor.white,
                            font: UIFont.main(), action: hideMessage)
        if seconds != Int.max {
            show(whistle: murmur, action: .show(Double(seconds)))
        } else {
            show(whistle: murmur, action: .present)
        }
        return murmur
    }

    
    static func hideMessage() {
        hide(whistleAfter: 0)
    }
    
    @discardableResult
    static func showMessage(_ message: String, inSeconds seconds: Int = 5) -> Murmur {
        let murmur = Murmur(title: message, backgroundColor: .CT_254_196_68,
                            titleColor: .CT_25,
                            font: UIFont.main(), action: hideMessage)
        if seconds != Int.max {
            show(whistle: murmur, action: .show(Double(seconds)))
        } else {
            show(whistle: murmur, action: .present)
        }
        return murmur
    }
    
}
