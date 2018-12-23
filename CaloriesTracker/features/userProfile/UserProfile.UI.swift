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
                                                  color: .CT_170)
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

            view.addSubviews(views: avatarImgView, detailView, backButton, mealView)
            let avatarHeight: CGFloat = 96
            avatarImgView.square(edge: avatarHeight)
            avatarImgView.setCorner(radius: avatarHeight / 2)
            avatarImgView.left(toView: view, space: padding)
            avatarImgView.centerY(toView: view)

            detailView.leftHorizontalSpacing(toView: avatarImgView, space: -padding)
            detailView.right(toView: view, space: -padding)
            detailView.centerY(toView: avatarImgView)

            backButton.topLeft(toView: view, top: padding + 16, left: 0)
            
            mealView.horizontal(toView: view)
            mealView.bottom(toView: view)
            
            view.height(320)
            return view
        }
    }
}

