//
//  ThisWeekMealsView.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/21/18.
//  Copyright © 2018 Coinhako. All rights reserved.
//

import UIKit

final class CTUpcomingMealsView: knGridView<CTUpcomingMealCell, CTMeal> {
    override var datasource: [CTMeal] {
        didSet {
            if datasource.count == 1 {
                let edge: CGFloat = screenWidth - padding * 2
                itemSize = CGSize(width: edge, height: 0)
            }
            collectionView.reloadData()
        }
    }
    override func setupView() {
        let label = UIMaker.makeLabel(text: "UPCOMING MEALS",
                                              font: UIFont.main(.bold, size: 15), color: .CT_25)
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
        addSubviews(views: label, collectionView)
        addConstraints(withFormat: "V:|[v0]-12-[v1]|", views: label, collectionView)
        label.left(toView: self, space: padding)
        collectionView.horizontal(toView: self)
    }
    
    override func didSelectItem(at indexPath: IndexPath) {
        let ctr = CTMealDetailCtr()
        ctr.data = datasource[indexPath.row]
        ctr.hidesBottomBarWhenPushed = true
        UIApplication.push(ctr)
    }
}

final class CTUpcomingMealCell: knGridCell<CTMeal> {
    override var data: CTMeal? { didSet {
        guard let data = data else { return }
        imgView.downloadImage(from: data.images.first)
        nameLabel.text = data.name
        ingredientLabel.text = data.ingredient
        let mealType = data.getMealTypeString().uppercased()
        if let date = data.date, let time = data.time {
            let dateTime = time + " - " + date
            caloriesLabel.text = "\(mealType) - \(dateTime)"
        } else {
            caloriesLabel.text = mealType
        }
        
        if let calories = data.calories {
            let caloriesSet = CaloriesTracker().getFormat(isStandard: data.isStandard)
            attentionView.backgroundColor = caloriesSet.bgColor
            messageLabel.text = caloriesSet.message + " - \(calories) KCAL"
            messageLabel.textColor = caloriesSet.textColor
        }
    }}
    let imgView = UIMaker.makeImageView(contentMode: .scaleAspectFill)
    let nameLabel = UIMaker.makeLabel(font: UIFont.main(.bold, size: 15),
                                             color: UIColor.CT_25)
    let ingredientLabel = UIMaker.makeLabel(font: UIFont.main(size: 12),
                                            color: UIColor.lightGray)
    let caloriesLabel = UIMaker.makeLabel(font: UIFont.main(.bold, size: 12),
                                        color: UIColor.lightGray)
    let messageLabel = UIMaker.makeLabel(font: UIFont.main(.bold),
                                         color: UIColor.lightGray)
    let attentionView = UIMaker.makeView()
    
    override func setupView() {
        attentionView.addSubviews(views: messageLabel)
        messageLabel.fill(toView: attentionView, space: UIEdgeInsets(space: padding / 2))
        
        let view = UIMaker.makeView(background: .white)
        view.setCorner(radius: 7)
        view.addSubviews(views: imgView, nameLabel, ingredientLabel, caloriesLabel, attentionView)
        view.addConstraints(withFormat: "V:|[v0]-16-[v1]-4-[v2]-4-[v3]-16-[v4]|", views: imgView, nameLabel, ingredientLabel, caloriesLabel, attentionView)
        imgView.horizontal(toView: view)
        imgView.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 239), for: .vertical)
        
        nameLabel.horizontal(toView: view, space: padding / 2)
        ingredientLabel.horizontal(toView: nameLabel)
        caloriesLabel.left(toView: nameLabel)
        attentionView.horizontal(toView: view)
        
        addSubview(view)
        view.fill(toView: self)
    }
}
