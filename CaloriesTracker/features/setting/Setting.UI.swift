//
//  Setting.UI.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/25/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit

extension CTSettingCtr {
    class UI {
        func setupView() -> [knTableCell] {
            return [
                CTSettingCell(title: "My profile", icon: "user_profile"),
                CTSettingCell(title: "Calories", icon: "calorie"),
                CTSettingCell(title: "Log out", icon: "logout"),
            ]
        }
    }
}

class CTSettingCell: knTableCell {
    convenience init(title: String, icon: String) {
        self.init()
        titleLabel.text = title
        iconImageView.image = UIImage(named: icon)
        iconImageView.changeColor(to: UIColor.main)
    }
    
    private let iconImageView = UIMaker.makeImageView()
    private let titleLabel = UIMaker.makeLabel(font: UIFont.main(.medium),
                                       color: UIColor.CT_25)
    
    override func setupView() {
        let line = UIMaker.makeHorizontalLine()
        addSubviews(views: iconImageView, titleLabel, line)
        
        iconImageView.left(toView: self, space: padding)
        iconImageView.centerY(toView: self)
        iconImageView.square(edge: 24)
        
        titleLabel.leftHorizontalSpacing(toView: iconImageView, space: -padding)
        titleLabel.centerY(toView: self)
        
        line.horizontal(toView: self)
        line.bottom(toView: self)
    }
}




