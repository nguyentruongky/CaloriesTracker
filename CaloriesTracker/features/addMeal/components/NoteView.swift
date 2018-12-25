//
//  NoteView.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/23/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit
class CTNoteView: knView {
    weak var parent: CTMealOptionView?
    let noteTextView = UIMaker.makeTextView(placeholder: "Your note goes here",
                                            font: UIFont.main(),
                                            color: UIColor.CT_25)
    let saveButton = UIMaker.makeMainButton(title: "Save and select food")
    let backButton = UIMaker.makeButton(title: "Change calories", titleColor: .CT_105, font: UIFont.main())

    override func setupView() {
        noteTextView.autocorrectionType = .no
        noteTextView.autocapitalizationType = .sentences
        
        backgroundColor = .white
        let wrapperView = UIMaker.makeView()
        wrapperView.addSubviews(views: noteTextView)
        noteTextView.fill(toView: wrapperView, space: UIEdgeInsets(space: 4))
        wrapperView.setCorner(radius: 7)
        wrapperView.setBorder(1, color: UIColor.CT_222)
        
        let title = "Any notes?"
        let titleLabel = UIMaker.makeLabel(text: title, font: UIFont.main(.bold, size: 17),
                                           color: .CT_25, numberOfLines: 2, alignment: .center)
        let view = UIMaker.makeView()
        view.addSubviews(views: titleLabel, wrapperView, saveButton, backButton)
        view.addConstraints(withFormat: "V:|-32-[v0]-32-[v1]-32-[v2]-24-[v3]-32-|", views: titleLabel, wrapperView, saveButton, backButton)
        titleLabel.horizontal(toView: view, space: padding)
        wrapperView.horizontal(toView: titleLabel)
        wrapperView.height(120)
        saveButton.horizontal(toView: titleLabel)
        backButton.centerX(toView: saveButton)
        
        addSubviews(views: view)
        view.horizontal(toView: self)
        view.top(toView: self)
        
        backButton.addTarget(self, action: #selector(changeCalories))
    }
    
    @objc func changeCalories() {
        parent?.collectionView.scrollToItem(at: IndexPath(row: 1, section: 0), at: .left, animated: true)
    }
}
