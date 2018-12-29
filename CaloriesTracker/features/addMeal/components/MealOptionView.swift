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
    
    weak var delegate: CTBottomSheetDelegate?

    override func setupView() {
        clipsToBounds = true
        tableView.estimatedRowHeight = 250
        super.setupView()
        addFill(tableView)
        datasource = ui.setupView()
        ui.noteTextView.delegate = self
        ui.saveButton.addTarget(self, action: #selector(saveMeal))
    }
    
    @objc func saveMeal() {
        meal.date = ui.date
        meal.time = ui.time
        meal.calories = Int(ui.caloriesSlider.value)
        meal.note = ui.noteTextView.text
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
}
