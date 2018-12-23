//
//  MealDetail.UI.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/23/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit

extension CTMealDetailCtr {
    class UI {
        let headerHeight: CGFloat = 250
        let fixedImgView = UIMaker.makeImageView(contentMode: .scaleAspectFill)
        let imgView = UIMaker.makeImageView(contentMode: .scaleAspectFill)
        let titleLabel = UIMaker.makeLabel(font: UIFont.main(.bold, size: 25),
                                           color: UIColor.CT_25, numberOfLines: 0)
        let timeLabel = UIMaker.makeLabel(font: UIFont.main(size: 14),
                                              color: UIColor.CT_170)
        let caloriesLabel = UIMaker.makeLabel(font: UIFont.main(.bold, size: 15),
                                          color: UIColor(r: 252, g: 61, b: 86))
        let messageLabel = UIMaker.makeLabel(font: UIFont.main(.bold, size: 12),
                                             color: UIColor.lightGray)
        let noteLabel = UIMaker.makeLabel(font: UIFont.main(size: 14),
                                          color: UIColor.CT_170, numberOfLines: 0)
        let ateFoodView = CTAteFoodView()
        
        lazy var attentionView = makeAttentionView()
        func makeAttentionView() -> UIView {
            let view = UIMaker.makeView()
            view.addSubviews(views: messageLabel)
            messageLabel.horizontal(toView: view, space: padding)
            messageLabel.centerY(toView: view)
            return view
        }
        
        func setupView() -> [knTableCell] {
            return [
                makeHeaderCell(),
                makeDetailCell(),
                makeNutritionCell(),
                makeFoodCell()
            ]
        }
        
        func makeDetailCell() -> knTableCell {
            let view = UIMaker.makeStackView(space: 16)
            view.addViews(titleLabel, noteLabel, timeLabel)
            titleLabel.horizontal(toView: view, space: padding)
            noteLabel.horizontal(toView: titleLabel)
            timeLabel.horizontal(toView: titleLabel)
            
            let cell = knTableCell()
            cell.addSubviews(views: view)
            view.fill(toView: cell, space: UIEdgeInsets(top: padding, bottom: padding))
            return cell
        }
        
        func makeNutritionCell() -> knTableCell {
            let calorieWrapper = UIMaker.makeView(background: .white)
            calorieWrapper.addSubviews(views: caloriesLabel)
            caloriesLabel.horizontal(toView: calorieWrapper, space: padding)
            caloriesLabel.centerY(toView: calorieWrapper)
            
            let cell = knTableCell()
            cell.backgroundColor = .clear
            cell.addSubviews(views: calorieWrapper, attentionView)
            cell.addConstraints(withFormat: "H:|-\(padding)-[v0]-12-[v1]", views: calorieWrapper, attentionView)
            calorieWrapper.vertical(toView: cell, topPadding: padding, bottomPadding: 0)
            let wrapperHeight: CGFloat = 36
            calorieWrapper.height(wrapperHeight)
            calorieWrapper.setCorner(radius: wrapperHeight / 2)
            attentionView.vertical(toView: calorieWrapper)
            attentionView.setCorner(radius: wrapperHeight / 2)
            return cell
        }
        
        func makeHeaderCell() -> knTableCell {
            let cell = knTableCell()
            cell.addSubviews(views: imgView)
            imgView.fill(toView: cell)
            imgView.height(headerHeight)
            return cell
        }
        
        func makeFoodCell() -> knTableCell {
            let titleLabel = UIMaker.makeLabel(text: "FOODS", font: UIFont.main(.bold, size: 12),
                                                 color: UIColor.CT_105)
            let cell = knTableCell()
            cell.backgroundColor = .clear
            cell.addSubviews(views: ateFoodView, titleLabel)
            cell.addConstraints(withFormat: "V:|-\(padding)-[v0]-12-[v1]-\(padding)-|", views: titleLabel, ateFoodView)
            titleLabel.left(toView: cell, space: padding)
            ateFoodView.horizontal(toView: cell)
            ateFoodView.height(200)
            return cell
        }
        
    }
}

