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
            caloryLabel.text = "\(mealType) - \(calorie) KCAL"
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
    let caloryLabel = UIMaker.makeLabel(font: UIFont.main(.bold, size: 12),
                                        color: UIColor.lightGray)
    let messageLabel = UIMaker.makeLabel(font: UIFont.main(),
                                         color: UIColor.lightGray)
    let attentionView = UIMaker.makeView()
    
    override func setupView() {
        attentionView.addSubviews(views: messageLabel)
        messageLabel.fill(toView: attentionView, space: UIEdgeInsets(space: padding / 2))
        backgroundColor = UIColor.bg
        let view = UIMaker.makeView(background: UIColor.white)
        view.setCorner(radius: 7)
        view.addSubviews(views: imgView, nameLabel, ingredientLabel, caloryLabel, attentionView)
        view.addConstraints(withFormat: "V:|-\(padding)-[v0]-8-[v1]-8-[v2]-\(padding)-[v3]|",
                            views: nameLabel, ingredientLabel, caloryLabel, imgView)
        nameLabel.horizontal(toView: view, space: padding)
        ingredientLabel.horizontal(toView: nameLabel)
        caloryLabel.horizontal(toView: nameLabel)
        
        imgView.horizontal(toView: view)
        imgView.height(200)
        imgView.setCorner(radius: 7)
        
        view.addSubview(attentionView)
        attentionView.setCorner(radius: 7)
        attentionView.topRight(toView: imgView)
        
        addSubview(view)
        view.fill(toView: self, space: UIEdgeInsets(left: padding, bottom: padding, right: padding))
    }
}

