//
//  ChangeCalories.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/26/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit

class CTCaloriesCtr: knController {
    let caloriesSlider: UISlider = {
        let view = UISlider()
        view.translatesAutoresizingMaskIntoConstraints = false
        let currentValue = Float(appSetting.standardCalories)
        view.minimumValue = min(1000, currentValue)
        view.maximumValue = currentValue * 2
        view.value = currentValue
        
        return view
    }()
    lazy var caloriesAmountLabel = UIMaker.makeLabel(text: String(Int(caloriesSlider.value)),
                                                     font: UIFont.main(.bold, size: 45),
                                                     color: .CT_25)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchData()
    }
    
    override func setupView() {
        title = "CALORIES LIMIT"
        navigationController?.hideBar(false)
        addBackButton(tintColor: .CT_25)
        caloriesSlider.addTarget(self, action: #selector(updateCaloriesValue), for: .valueChanged)
        caloriesSlider.addTarget(self, action: #selector(endEditing), for: .touchUpOutside)
        caloriesSlider.addTarget(self, action: #selector(endEditing), for: .touchUpInside)
        let question = "How many calories would you like to eat a day?"
        let titleLabel = UIMaker.makeLabel(text: question, font: UIFont.main(.medium, size: 17),
                                           color: .CT_25, numberOfLines: 2)
        view.addSubviews(views: titleLabel, caloriesAmountLabel, caloriesSlider)
        view.addConstraints(withFormat: "V:|-64-[v0]-24-[v1]-24-[v2]", views: titleLabel, caloriesAmountLabel, caloriesSlider)
        titleLabel.horizontal(toView: view, space: padding)
        caloriesAmountLabel.centerX(toView: view)
        caloriesSlider.horizontal(toView: titleLabel)
    }
    
    override func fetchData() {
        CTGetCaloriesWorker(successAction: didGetCalories).execute()
    }
    
    private func didGetCalories(_ calories: Int) {
        caloriesAmountLabel.text = String(calories)
        appSetting.standardCalories = calories
        caloriesSlider.value = Float(calories)
        caloriesSlider.minimumValue = Float(min(1000, calories))
        caloriesSlider.maximumValue = Float(max(2500, calories * 2))
    }
    
    @objc private func updateCaloriesValue() {
        let calories = Int(caloriesSlider.value)
        caloriesAmountLabel.text = String(calories)
        appSetting.standardCalories = calories
    }
    
    @objc private func endEditing() {
        CTMealsDashboard.needRecheckCalories = true
        CTUpdateCaloriesWorker(calories: Int(caloriesSlider.value)).execute()
    }
}
