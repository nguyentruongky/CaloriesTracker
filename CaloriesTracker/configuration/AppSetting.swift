//
//  1.Setting.swift
//  knCollection
//
//  Created by Ky Nguyen Coinhako on 7/3/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit

var appSetting = AppSetting()
struct AppSetting {
    let ADMIN = "vsoOZW6nGUUcDa5I7nn3L9pJbrn1"
    let DEFAULT_CALORIES = 2000
    var user: CTUser? { didSet {
        userRole = (user?.role ?? UserRole.user)
        userId = user?.userId
    }}
    
    var userId: String? {
        get { return UserDefaults.get(key: "userId") as String? }
        set { UserDefaults.set(key: "userId", value: newValue) }
    }
    
    var userRole: UserRole {
        get {
            guard let raw = UserDefaults.get(key: "userRole") as String?
                else { return UserRole.user }
            guard let role = UserRole(rawValue: raw) else { return UserRole.user }
            return role
        }
        set { UserDefaults.set(key: "userRole", value: newValue.rawValue) }
    }
    var didLogin: Bool {
        get { return UserDefaults.get(key: "didLogin") as Bool? ?? false }
        set { UserDefaults.set(key: "didLogin", value: newValue) }
    }
    var standardCalories: Int {
        get { return UserDefaults.get(key: "standardCalories") as Int? ?? DEFAULT_CALORIES }
        set { UserDefaults.set(key: "standardCalories", value: newValue) }
    }
}

let padding: CGFloat = 24
