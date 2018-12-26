//
//  FoodDetail.UI.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/23/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit

extension CTFoodDetailCtr {
    class UI {
        let headerHeight: CGFloat = 250
        let fixedImgView = UIMaker.makeImageView(contentMode: .scaleAspectFill)
        let imgView = UIMaker.makeImageView(contentMode: .scaleAspectFill)
        let titleLabel = UIMaker.makeLabel(font: UIFont.main(.bold, size: 20),
                                           color: UIColor.CT_25, numberOfLines: 0)
        let caloriesLabel = UIMaker.makeLabel(font: UIFont.main(.bold, size: 15),
                                              color: UIColor(r: 252, g: 61, b: 86))
        
        let ingredientLabel = UIMaker.makeLabel(font: UIFont.main(size: 15),
                                                 color: UIColor.CT_25)
        let selectButton = UIMaker.makeMainButton(title: "Select this food")
        let removeButton = UIMaker.makeMainButton(title: "Unselect", bgColor: .white, titleColor: .main)
        var backButton: UIButton!
        
        func setupView() -> [knTableCell] {
            let headerCell = makeHeaderCell()
            headerCell.height(headerHeight)
            let titleCell = makeTitleCell()
            return [headerCell, titleCell]
        }
        
        func addSelectButton(to view: UIView) {
            view.addSubviews(views: selectButton, removeButton)
            selectButton.horizontal(toView: view, space: padding)
            selectButton.bottom(toView: view, space: -(view.safeAreaInsets.bottom + padding * 1.5))
            
            removeButton.fill(toView: selectButton)
            removeButton.setBorder(1, color: UIColor.main)
            removeButton.isHidden = true
        }
        
        func makeTitleCell() -> knTableCell {
            let cell = knTableCell()
            cell.addSubviews(views: titleLabel, caloriesLabel)
            cell.addConstraints(withFormat: "V:|-\(padding / 2)-[v0]-\(padding / 3)-[v1]|", views: titleLabel, caloriesLabel)
            titleLabel.horizontal(toView: cell, space: padding)
            caloriesLabel.horizontal(toView: titleLabel)
            return cell
        }
        
        func makeTextCell(title: String, content: String?) -> knTableCell {
            let headerLabel = UIMaker.makeLabel(text: title, font: UIFont.main(.bold, size: 15),
                                                color: UIColor.CT_25)
            let contentLabel = UIMaker.makeLabel(text: content, font: UIFont.main(size: 13),
                                                     color: UIColor.CT_105, numberOfLines: 0)
            let cell = knTableCell()
            cell.addSubviews(views: headerLabel, contentLabel)
            cell.addConstraints(withFormat: "V:|-\(padding)-[v0]-\(padding / 3)-[v1]|", views: headerLabel, contentLabel)
            headerLabel.horizontal(toView: cell, space: padding)
            contentLabel.horizontal(toView: headerLabel)
            return cell
        }
        
        func makeHeaderCell() -> knTableCell {
            let cell = knTableCell()
            cell.backgroundColor = .clear
            cell.addSubviews(views: imgView)
            imgView.fill(toView: cell)
            imgView.clipsToBounds = true
            return cell
        }
    }
}

