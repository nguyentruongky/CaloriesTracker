//
//  SelectedOptionsView.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/24/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit

class CTSelectedOptionsView: knView {
    weak var parent: CTMealOptionView?
    let titleLabel = UIMaker.makeLabel(font: UIFont.main(.bold, size: 15),
                                       color: .CT_25, numberOfLines: 0)
    let backButton = UIMaker.makeButton(title: "Change time", titleColor: .CT_105, font: UIFont.main())
    let saveButton = UIMaker.makeMainButton(title: "Confirm")
    func format(meal: CTMeal) {
        guard let date = meal.date, let time = meal.time, let calories = meal.calorie, let note = meal.note else { return }
        let mealType = meal.getMealTypeString()
        var text = "Your \(mealType) is on \(time), \(date) with \(calories) KCAL."
        if note.isEmpty == false {
            text += "\nNote: \(note)"
        }
        let formatted = String.format(strings: [date, time, mealType, String(calories) + " KCAL", note],
                                      boldFont: UIFont.main(.bold, size: 17),
                                      boldColor: .CT_25,
                                      inString: text,
                                      font: UIFont.main(),
                                      color: .CT_25,
                                      lineSpacing: 7)
        titleLabel.attributedText = formatted
    }
    
    override func setupView() {
        backgroundColor = .white
        let view = UIMaker.makeView()
        view.addSubviews(views: titleLabel, saveButton, backButton)
        view.addConstraints(withFormat: "V:|[v0]-24-[v1]-24-[v2]-\(padding)-|", views: titleLabel, saveButton, backButton)
        titleLabel.horizontal(toView: view, space: padding)
        saveButton.horizontal(toView: view, space: padding)
        backButton.centerX(toView: view)
        backButton.addTarget(self, action: #selector(changeTime))
        
        addSubviews(views: view)
        view.horizontal(toView: self)
        view.top(toView: self, space: padding)
        
        saveButton.addTarget(self, action: #selector(saveMeal))
    }
    
    @objc func saveMeal() {
        parent?.saveMeal()
    }
    
    @objc func changeTime() {
        parent?.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: true)
    }
}
