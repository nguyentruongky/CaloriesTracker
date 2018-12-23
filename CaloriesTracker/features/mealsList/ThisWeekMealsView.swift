//
//  ThisWeekMealsView.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/21/18.
//  Copyright © 2018 Coinhako. All rights reserved.
//

import UIKit

final class ThisWeekView: knGridView<ThisWeekMealCell, CTMeal> {
    override var datasource: [CTMeal] {
        didSet {
            if datasource.count == 1 {
                let edge: CGFloat = screenWidth - padding * 2
                itemSize = CGSize(width: edge, height: 0)
                collectionView.reloadData()
            }
        }
    }
    override func setupView() {
        backgroundColor = UIColor.bg
        let edge: CGFloat = screenWidth - padding * 3
        lineSpacing = padding / 1.5
        layout = FAPaginationLayout()
        (layout as? FAPaginationLayout)?.scrollDirection = .horizontal
        itemSize = CGSize(width: edge, height: 0)
        let leftSpacing: CGFloat = padding
        contentInset = UIEdgeInsets(left: leftSpacing, right: leftSpacing)
        super.setupView()
        collectionView.backgroundColor = UIColor.bg
        addSubviews(views: collectionView)
        collectionView.fill(toView: self)
    }
}

final class ThisWeekMealCell: knGridCell<CTMeal> {
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
        
        let view = UIMaker.makeView(background: .white)
        view.setCorner(radius: 7)
        view.addSubviews(views: imgView, nameLabel, ingredientLabel, caloryLabel, attentionView)
        view.addConstraints(withFormat: "V:|[v0]-16-[v1]-4-[v2]-4-[v3]-16-[v4]|", views: imgView, nameLabel, ingredientLabel, caloryLabel, attentionView)
        imgView.horizontal(toView: view)
        imgView.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 239), for: .vertical)
        
        nameLabel.horizontal(toView: view, space: padding / 2)
        ingredientLabel.horizontal(toView: nameLabel)
        caloryLabel.left(toView: nameLabel)
        attentionView.horizontal(toView: view)
        
        addSubview(view)
        view.fill(toView: self)
    }
}
