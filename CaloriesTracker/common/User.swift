//
//  User.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/27/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import Foundation

class CTUser {
    var email: String?
    var name: String?
    var userId: String?
    var avatar: String?
    var role: UserRole = .user
    var calories = 2000
    var isActive = true
    
    init() { }
    init(name: String, avatar: String) {
        self.name = name
        self.avatar = avatar
    }
    
    init(raw: AnyObject) {
        userId = raw["user_id"] as? String
        if let roleRaw = raw["role"] as? String, let role = UserRole(rawValue: roleRaw) {
            self.role = role
        }
        name = raw["name"] as? String
        email = raw["email"] as? String
        avatar = raw["avatar"] as? String
        calories = raw["calories_limit"] as? Int ?? 2000
        isActive = raw["is_active"] as? Bool ?? true
    }
    
    init(id: String, name: String, email: String, role: UserRole) {
        userId = id
        self.name = name
        self.email = email
        self.role = role
    }
    
    func toDict() -> [String: Any?] {
        return [
            "user_id": userId,
            "role": UserRole.user.rawValue,
            "name": name,
            "email": email,
            "avatar": avatar,
            "calories_limit": calories,
            "is_active": isActive
        ]
    }
}
