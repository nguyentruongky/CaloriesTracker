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
        imgView.downloadImage(from: data?.image)
        nameLabel.text = data?.name
        ingredientLabel.text = data?.ingredient
        let mealType = data?.mealType.rawValue.uppercased() ?? ""
        if let calorie = data?.calorie {
            calorieLabel.text = "\(mealType) - \(calorie) KCAL"
            if calorie > appSetting.standardCalory {
                attentionView.backgroundColor = .red
                messageLabel.text = "High calories"
                messageLabel.textColor = .white
            } else {
                attentionView.backgroundColor = .green
                messageLabel.text = "Standard"
                messageLabel.textColor = .darkGray
            }
        }
        }}
    let imgView = UIMaker.makeImageView(contentMode: .scaleAspectFill)
    let nameLabel = UIMaker.makeLabel(font: UIFont.main(.bold, size: 15),
                                      color: UIColor.CT_25)
    let ingredientLabel = UIMaker.makeLabel(font: UIFont.main(size: 12),
                                            color: UIColor.lightGray)
    let calorieLabel = UIMaker.makeLabel(font: UIFont.main(.bold, size: 12),
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
        view.addSubviews(views: imgView, nameLabel, ingredientLabel, calorieLabel, attentionView)
        view.addConstraints(withFormat: "V:|-\(padding)-[v0]-8-[v1]-8-[v2]",
                            views: nameLabel, ingredientLabel, calorieLabel)
        nameLabel.horizontal(toView: view, space: padding)
        ingredientLabel.horizontal(toView: nameLabel)
        calorieLabel.left(toView: nameLabel)
        
        imgView.horizontal(toView: view)
        imgView.bottom(toView: view)
        imgView.height(140)
        
        view.addSubview(attentionView)
        attentionView.leftHorizontalSpacing(toView: calorieLabel, space: -4)
        attentionView.centerY(toView: calorieLabel)
        let attentionHeight: CGFloat = 20
        attentionView.height(attentionHeight)
        attentionView.setCorner(radius: attentionHeight / 2)

        addSubview(view)
        view.fill(toView: self, space: UIEdgeInsets(left: padding, bottom: padding, right: padding))
    }
}

