//
//  NoteView.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/23/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit
class CTNoteView: knView {
    let noteTextView = UIMaker.makeTextView(placeholder: "Your note goes here",
                                            font: UIFont.main(),
                                            color: UIColor.CT_25)
    let saveButton = UIMaker.makeMainButton(title: "Save and select food")
    
    override func setupView() {
        let wrapperView = UIMaker.makeView()
        wrapperView.addSubviews(views: noteTextView)
        noteTextView.fill(toView: wrapperView, space: UIEdgeInsets(space: 4))
        wrapperView.setCorner(radius: 7)
        wrapperView.setBorder(1, color: UIColor.CT_222)
        
        let title = "Any notes for us?"
        let titleLabel = UIMaker.makeLabel(text: title, font: UIFont.main(.bold, size: 17),
                                           color: .CT_25, numberOfLines: 2, alignment: .center)
        let view = UIMaker.makeView()
        view.addSubviews(views: titleLabel, wrapperView, saveButton)
        view.addConstraints(withFormat: "V:|-32-[v0]-32-[v1]-32-[v2]-32-|", views: titleLabel, wrapperView, saveButton)
        titleLabel.horizontal(toView: view, space: padding)
        wrapperView.horizontal(toView: titleLabel)
        wrapperView.height(120)
        saveButton.horizontal(toView: titleLabel)
        
        addSubviews(views: view)
        view.horizontal(toView: self)
        view.top(toView: self)
    }
}
