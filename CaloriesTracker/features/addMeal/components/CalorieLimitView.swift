//
//  CalorieLimitView.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/23/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit
class CTCalorieLimitView: knView {
    weak var parent: CTMealOptionView?
    
    let slider: UISlider = {
        let view = UISlider()
        view.translatesAutoresizingMaskIntoConstraints = false
        let currentValue = Float(appSetting.standardCalory)
        view.minimumValue = currentValue / 2
        view.maximumValue = currentValue * 1.5
        view.value = currentValue

        return view
    }()
    let amountLabel = UIMaker.makeLabel(text: String(appSetting.standardCalory),
                                        font: UIFont.main(.bold, size: 45),
                                        color: .CT_25)
    let saveButton = UIMaker.makeMainButton(title: "Save and next")
    let backButton = UIMaker.makeButton(title: "Change time", titleColor: .CT_105, font: UIFont.main())
    
    override func setupView() {
        backgroundColor = .white
        slider.addTarget(self, action: #selector(updateValue), for: .valueChanged)
        
        let title = "How many calories would you like to eat?"
        let titleLabel = UIMaker.makeLabel(text: title, font: UIFont.main(.bold, size: 17),
                                           color: .CT_25, numberOfLines: 2, alignment: .center)
        let view = UIMaker.makeView()
        view.addSubviews(views: titleLabel, amountLabel, slider, saveButton, backButton)
        view.addConstraints(withFormat: "V:|-32-[v0]-24-[v1]-24-[v2]-24-[v3]-16-[v4]-32-|", views: titleLabel, amountLabel, slider, saveButton, backButton)
        titleLabel.horizontal(toView: view, space: padding)
        amountLabel.centerX(toView: view)
        slider.horizontal(toView: titleLabel)
        saveButton.horizontal(toView: slider)
        
        backButton.centerX(toView: saveButton)
        
        addSubviews(views: view)
        view.horizontal(toView: self)
        view.top(toView: self)
        
        backButton.addTarget(self, action: #selector(changeTime))
    }
    
    @objc func changeTime() {
        parent?.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: true)
    }
    
    @objc func updateValue() {
        amountLabel.text = String(Int(slider.value))
    }
}
