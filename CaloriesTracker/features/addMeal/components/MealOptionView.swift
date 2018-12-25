//
//  MealOptionView.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/22/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit

class CTStepCell: knGridCell<UIView> {
    override var data: UIView? { didSet {
        guard let view = data else { return }
        addSubviews(views: view)
        view.fill(toView: self)
    }}
}

class CTMealOptionView: knGridView<CTStepCell, UIView> {
    var meal = CTMeal()
    
    let panView = UIMaker.makeView(background: UIColor(value: 200))
    weak var delegate: CTBottomSheetDelegate?
    let mealTime = CTMealTimeView()
    let calorieLimit = CTCalorieLimitView()
    let noteView = CTNoteView()
    let finalView = CTSelectedOptionsView()

    override func setupView() {
        layout = UICollectionViewFlowLayout()
        layout!.scrollDirection = .horizontal
        itemSize = CGSize(width: screenWidth, height: 0)
        super.setupView()
        collectionView.isPagingEnabled = true
        let panIndicator = UIMaker.makeView(background: UIColor.lightGray.alpha(0.5))
        panView.addSubviews(views: panIndicator)
        panIndicator.size(CGSize(width: 75, height: 5))
        panIndicator.setCorner(radius: 2.5)
        panIndicator.center(toView: panView)
        
        addSubviews(views: collectionView, panView)
        panView.horizontal(toView: self)
        panView.top(toView: self)
        panView.height(24)
        
        collectionView.horizontal(toView: self)
        collectionView.verticalSpacing(toView: panView)
        collectionView.bottom(toView: self)
        
        clipsToBounds = true
        collectionView.isScrollEnabled = false
        
        mealTime.saveButton.addTarget(self, action: #selector(showCalorieLimit))
        
        calorieLimit.parent = self
        calorieLimit.saveButton.addTarget(self, action: #selector(showNote))
        
        noteView.saveButton.addTarget(self, action: #selector(hideBottomSheet))
        noteView.parent = self
        
        finalView.parent = self
        
        datasource = [
            mealTime, calorieLimit, noteView, finalView
        ]
    }
    
    @objc func showCalorieLimit() {
        collectionView.scrollToItem(at: IndexPath(row: 1, section: 0), at: .left, animated: true)
        meal.date = mealTime.date
        meal.time = mealTime.time
    }
    
    @objc func showNote() {
        collectionView.scrollToItem(at: IndexPath(row: 2, section: 0), at: .left, animated: true)
        meal.calorie = Int(calorieLimit.slider.value)
    }
    
    @objc func hideBottomSheet() {
        meal.note = noteView.noteTextView.text
        delegate?.hideSheet()
        finalView.format(meal: meal)
        collectionView.scrollToItem(at: IndexPath(row: 3, section: 0), at: .left, animated: true)
        hideKeyboard()
    }
    
    func saveMeal() {
        delegate?.saveMeal()
    }
}

protocol CTBottomSheetDelegate: class {
    func hideSheet()
    
    func saveMeal()
}
