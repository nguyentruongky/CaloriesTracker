//
//  MealOptionView.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/22/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit

class CTMealOptionView: knStaticListView {
    let ui = UI()
    var meal = CTMeal()
    
    let panView = UIMaker.makeView(background: UIColor(value: 200))
    weak var delegate: CTBottomSheetDelegate?

    override func setupView() {
        clipsToBounds = true
        super.setupView()
        tableView.estimatedRowHeight = 250

        let panIndicator = UIMaker.makeView(background: UIColor.lightGray.alpha(0.5))
        panView.addSubviews(views: panIndicator)
        panIndicator.size(CGSize(width: 75, height: 5))
        panIndicator.setCorner(radius: 2.5)
        panIndicator.center(toView: panView)
        
        addSubviews(views: tableView, panView)
        panView.horizontal(toView: self)
        panView.top(toView: self)
        panView.height(24)
        
        tableView.horizontal(toView: self)
        tableView.verticalSpacing(toView: panView)
        tableView.bottom(toView: self)
        
        datasource = ui.setupView()
        ui.noteTextView.delegate = self
        ui.saveButton.addTarget(self, action: #selector(saveMeal))
    }
    
    @objc func saveMeal() {
        meal.date = ui.date
        meal.time = ui.time
        meal.calorie = Int(ui.caloriesSlider.value)
        meal.note = ui.noteTextView.text
        delegate?.saveMeal()
        delegate?.hideSheet()
    }
}

extension CTMealOptionView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        tableView.contentInset = UIEdgeInsets(bottom: 280)
        tableView.scrollToRow(at: IndexPath(row: 2, section: 0), at: .bottom, animated: true)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        UIView.animate(withDuration: 0.35, animations: {[weak self] in
            self?.tableView.contentInset = UIEdgeInsets(bottom: 0)
        })
    }
}


protocol CTBottomSheetDelegate: class {
    func hideSheet()
    
    func saveMeal()
}
