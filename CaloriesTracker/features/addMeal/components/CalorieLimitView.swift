//
//  CalorieLimitView.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/23/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit
class CTCalorieLimitView: knView {
    let slider: UISlider = {
        let view = UISlider()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let amountLabel = UIMaker.makeLabel(text: String(appSetting.standardCalory),
                                        font: UIFont.main(.bold, size: 45),
                                        color: .CT_25)
    let saveButton = UIMaker.makeMainButton(title: "Save and next")
    override func setupView() {
        let title = "How many calories do you want to eat?"
        let titleLabel = UIMaker.makeLabel(text: title, font: UIFont.main(.bold, size: 17),
                                           color: .CT_25, numberOfLines: 2, alignment: .center)
        let view = UIMaker.makeView()
        view.addSubviews(views: titleLabel, amountLabel, slider, saveButton)
        view.addConstraints(withFormat: "V:|-32-[v0]-32-[v1]-32-[v2]-32-[v3]-32-|", views: titleLabel, amountLabel, slider, saveButton)
        titleLabel.horizontal(toView: view, space: padding)
        amountLabel.centerX(toView: view)
        slider.horizontal(toView: titleLabel)
        saveButton.horizontal(toView: slider)
        
        addSubviews(views: view)
        view.horizontal(toView: self)
        view.top(toView: self)
    }
}
