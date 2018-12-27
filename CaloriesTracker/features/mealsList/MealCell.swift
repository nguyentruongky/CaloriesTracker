//
//  MealCell.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/21/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit
final class CTMealCell: knListCell<CTMeal> {
    override var data: CTMeal? { didSet {
        guard let data = data else { return }
        imgView.downloadImage(from: data.images.first)
        nameLabel.text = data.name
        timeLabel.text = data.getMealTypeString().uppercased()
        if let date = data.date, let time = data.time {
            timeLabel.text = timeLabel.text! + " - \(time) - \(date)"
        }
        
        if let calories = data.calories {
            caloriesLabel.text = "\(calories) KCAL"
            let caloriesSet = CaloriesTracker().getFormat(isStandard: data.isStandard)
            attentionView.backgroundColor = caloriesSet.bgColor
            messageLabel.text = caloriesSet.message
            messageLabel.textColor = caloriesSet.textColor
        }
    }}
    let imgView = UIMaker.makeImageView(contentMode: .scaleAspectFill)
    let nameLabel = UIMaker.makeLabel(font: UIFont.main(.bold, size: 15),
                                      color: UIColor.CT_25)
    let timeLabel = UIMaker.makeLabel(font: UIFont.main(.bold, size: 12),
                                            color: UIColor.lightGray)
    let caloriesLabel = UIMaker.makeLabel(font: UIFont.main(.bold, size: 12),
                                        color: UIColor.lightGray)
    let messageLabel = UIMaker.makeLabel(font: UIFont.main(.bold, size: 12),
                                         color: UIColor.lightGray)
    let attentionView = UIMaker.makeView()
    
    override func setupView() {
        attentionView.addSubviews(views: messageLabel)
        messageLabel.horizontal(toView: attentionView, space: 8)
        messageLabel.centerY(toView: attentionView)
        
        backgroundColor = UIColor.bg
        let view = UIMaker.makeView(background: UIColor.white)
        view.setCorner(radius: 7)
        view.addSubviews(views: imgView, nameLabel, timeLabel, caloriesLabel, attentionView)
        view.addConstraints(withFormat: "V:|-\(padding / 2)-[v0]-8-[v1]-8-[v2]",
                            views: nameLabel, timeLabel, caloriesLabel)
        nameLabel.horizontal(toView: view, space: padding / 2)
        timeLabel.horizontal(toView: nameLabel)
        caloriesLabel.left(toView: nameLabel)
        
        imgView.horizontal(toView: view)
        imgView.bottom(toView: view)
        imgView.height(140)
        
        view.addSubview(attentionView)
        attentionView.leftHorizontalSpacing(toView: caloriesLabel, space: -4)
        attentionView.centerY(toView: caloriesLabel)
        let attentionHeight: CGFloat = 20
        attentionView.height(attentionHeight)
        attentionView.setCorner(radius: attentionHeight / 2)

        addSubview(view)
        view.fill(toView: self, space: UIEdgeInsets(left: padding, bottom: padding, right: padding))
        backgroundColor = .bg
    }
}

