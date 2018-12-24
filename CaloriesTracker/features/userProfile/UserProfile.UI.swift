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
        let avatarImgView = UIMaker.makeImageView(contentMode: .scaleAspectFill)
        let nameTextField = UIMaker.makeTextField(font: UIFont.main(.bold, size: 20),
                                                  color: .CT_25)
        let emailTextField = UIMaker.makeTextField(font: UIFont.main(size: 14),
                                                  color: .CT_25)
        let calorieLimitTextField = UIMaker.makeTextField(font: UIFont.main(.bold, size: 28),
                                                   color: .CT_25, alignment: .center)
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
            
        func makeHeaderView() -> UIView {
            let mealLabel = UIMaker.makeLabel(text: "MEALS", font: UIFont.main(.bold, size: 17),
                                              color: .CT_25)
            let mealView = UIMaker.makeView(background: .bg)
            mealView.addSubviews(views: mealLabel)
            mealLabel.left(toView: mealView, space: padding)
            mealLabel.vertical(toView: mealView, space: padding)
            
            let view = UIMaker.makeView()
            let detailView = UIMaker.makeStackView(distributon: .fill, alignment: .leading, space: 8)
            detailView.addViews(nameTextField, emailTextField, editButton)
            nameTextField.left(toView: detailView)
            emailTextField.left(toView: detailView)

            editButton.left(toView: detailView)
            let editHeight: CGFloat = 32
            editButton.size(CGSize(width: 100, height: editHeight))
            editButton.setCorner(radius: editHeight / 2)

            let figureView = makeFigureView()
            
            view.addSubviews(views: avatarImgView, detailView, backButton, figureView, mealView)
            backButton.topLeft(toView: view, top: padding + 16, left: 0)
            
            let avatarHeight: CGFloat = 96
            avatarImgView.square(edge: avatarHeight)
            avatarImgView.setCorner(radius: avatarHeight / 2)
            avatarImgView.left(toView: view, space: padding)
            avatarImgView.verticalSpacing(toView: backButton, space: padding / 3)

            detailView.leftHorizontalSpacing(toView: avatarImgView, space: -padding)
            detailView.right(toView: view, space: -padding)
            detailView.centerY(toView: avatarImgView)

            figureView.verticalSpacing(toView: avatarImgView, space: padding / 1.7)
            figureView.horizontal(toView: view, space: padding)
            
            mealView.horizontal(toView: view)
            mealView.bottom(toView: view)
            
            view.height(370)
            return view
        }
        
        private func makeFigureView() -> UIView {
            func makeView(contentView: UIView, title: String) -> UIView {
                let titleView = UIMaker.makeLabel(text: title, font: UIFont.main(),
                                                  color: .CT_170, alignment: .center)

                let view = UIMaker.makeView()
                view.addSubviews(views: contentView, titleView)
                view.addConstraints(withFormat: "V:|[v0]-8-[v1]|", views: contentView, titleView)
                contentView.horizontal(toView: view)
                titleView.horizontal(toView: view)
                return view
            }
            let view = UIMaker.makeView(background: UIColor(value: 250))
            let mealView = makeView(contentView: mealCountTextField, title: "meals")
            let caloriesView = makeView(contentView: calorieLimitTextField, title: "KCAL/meal")

            view.addSubviews(views: mealView, caloriesView)
            view.addConstraints(withFormat: "H:|[v0][v1]|", views: mealView, caloriesView)
            mealView.vertical(toView: view, space: padding / 3)
            caloriesView.vertical(toView: mealView)
            caloriesView.width(toView: mealView)
            
            view.setCorner(radius: 15)
            return view
        }
    }
}

