//
//  UserProfile.UI.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/24/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit

extension CTUserProfileCtr {
    class UI {
        let avatarImgView = UIMaker.makeImageView(image: UIImage(named: "user_profile"), contentMode: .scaleAspectFill)
        let emailLabel = UIMaker.makeLabel(font: UIFont.main(size: 14),
                                     color: .CT_25)
        let nameTextField = UIMaker.makeTextField(font: UIFont.main(.bold, size: 20),
                                                  color: .CT_25)
        let calorieLimitTextField = UIMaker.makeTextField(font: UIFont.main(.bold, size: 28),
                                                   color: .CT_25, alignment: .center)
        let changeCaloriesButton = UIMaker.makeButton()
        let mealCountTextField = UIMaker.makeTextField(font: UIFont.main(.bold, size: 28),
                                                   color: .CT_25, alignment: .center)
        
        let editButton = UIMaker.makeButton(title: "Edit",
                                            titleColor: UIColor.white,
                                            font: UIFont.main(.bold, size: 14),
                                            background: UIColor(r: 250, g: 103, b: 105))
        
        lazy var backButton = makeBackButton()
        private func makeBackButton() -> UIButton {
            let button = UIMaker.makeButton(image: UIImage(named: "back_arrow")?.changeColor())
            button.imageView?.changeColor(to: .CT_25)
            button.square(edge: 44)
            return button
        }
        
        let mealTitleView = UIMaker.makeView(background: .bg)

        func makeHeaderView() -> UIView {
            nameTextField.autocorrectionType = .no
            nameTextField.autocapitalizationType = .words
            nameTextField.isEnabled = false
            avatarImgView.isUserInteractionEnabled = true
            let mealLabel = UIMaker.makeLabel(text: "MEALS", font: UIFont.main(.bold, size: 17),
                                              color: .CT_25)
            mealTitleView.addSubviews(views: mealLabel)
            mealLabel.left(toView: mealTitleView, space: padding)
            mealLabel.vertical(toView: mealTitleView, space: padding)
            
            let view = UIMaker.makeView(background: .white)
            let detailView = UIMaker.makeStackView(distributon: .fill, alignment: .leading, space: 8)
            detailView.addViews(nameTextField, emailLabel, editButton)
            nameTextField.left(toView: detailView)
            emailLabel.left(toView: detailView)

            editButton.left(toView: detailView)
            let editHeight: CGFloat = 32
            editButton.size(CGSize(width: 100, height: editHeight))
            editButton.setCorner(radius: editHeight / 2)

            let figureView = makeFigureView()
            
            view.addSubviews(views: avatarImgView, detailView, backButton, figureView, mealTitleView)
            backButton.contentVerticalAlignment = .top
            backButton.topLeft(toView: view, top: hasNotch() ? 0 : 16, left: 0)
            
            let avatarHeight: CGFloat = 96
            avatarImgView.square(edge: avatarHeight)
            avatarImgView.setCorner(radius: avatarHeight / 2)
            avatarImgView.left(toView: view, space: padding)
            avatarImgView.verticalSpacing(toView: backButton, space: hasNotch() ? 8 : -8)

            detailView.leftHorizontalSpacing(toView: avatarImgView, space: -padding)
            detailView.right(toView: view, space: -padding)
            detailView.centerY(toView: avatarImgView)

            figureView.horizontal(toView: view)
            figureView.verticalSpacing(toView: avatarImgView, space: padding)
            figureView.verticalSpacingDown(toView: mealTitleView)
            
            figureView.addSubview(changeCaloriesButton)
            changeCaloriesButton.fill(toView: calorieLimitTextField)
            
            mealTitleView.horizontal(toView: view)            
            return view
        }
        
        private func makeFigureView() -> UIView {
            func makeView(contentView: UIView, title: String) -> UIView {
                let titleView = UIMaker.makeLabel(text: title, font: UIFont.main(size: 12),
                                                  color: .CT_170, alignment: .center)

                let view = UIMaker.makeView()
                view.addSubviews(views: contentView, titleView)
                view.addConstraints(withFormat: "V:|[v0]-2-[v1]|", views: contentView, titleView)
                contentView.horizontal(toView: view)
                titleView.horizontal(toView: view)
                return view
            }
            mealCountTextField.isEnabled = false
            
            let verticalLine = UIMaker.makeVerticalLine(color: UIColor.CT_222, width: 1)
            let line = UIMaker.makeHorizontalLine(color: UIColor.CT_222, height: 1)
            let bottomLine = UIMaker.makeHorizontalLine(color: UIColor.CT_222, height: 1)
            let view = UIMaker.makeView(background: UIColor.white)
            let mealView = makeView(contentView: mealCountTextField, title: "meals")
            let caloriesView = makeView(contentView: calorieLimitTextField, title: "KCAL/day")

            view.addSubviews(views: mealView, caloriesView, line, verticalLine, bottomLine)
            view.addConstraints(withFormat: "H:|[v0][v1]|", views: mealView, caloriesView)
            mealView.vertical(toView: view, space: padding / 3)
            caloriesView.vertical(toView: mealView)
            caloriesView.width(toView: mealView)
            
            verticalLine.left(toView: caloriesView)
            verticalLine.vertical(toView: view)
            
            line.horizontal(toView: view)
            line.top(toView: view)
            
            bottomLine.horizontal(toView: view)
            bottomLine.bottom(toView: view)
            
            return view
        }
    }
}

