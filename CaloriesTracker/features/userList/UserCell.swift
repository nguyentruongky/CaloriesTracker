//
//  UserCell.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/24/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit

class CTUserDetail {
    var user: CTUser?
    var mealCount = 0
    init(user: CTUser, mealCount: Int) {
        self.user = user
        self.mealCount = mealCount
    }
}

class CTUserCell: knListCell<CTUserDetail> {
    override var data: CTUserDetail? { didSet {
        avatarImgView.downloadImage(from: data?.user?.avatar)
        nameLabel.text = data?.user?.name
        let mealCount = data?.mealCount ?? 0
        mealCountLabel.text = "\(mealCount) meals"
    }}
    
    let avatarImgView = UIMaker.makeImageView(contentMode: .scaleAspectFill)
    let nameLabel = UIMaker.makeLabel(font: UIFont.main(.bold, size: 14),
                                      color: UIColor.CT_25, alignment: .center)
    let mealCountLabel = UIMaker.makeLabel(font: UIFont.main(size: 12),
                                      color: UIColor.CT_105, alignment: .center)
    let deleteButton = UIMaker.makeButton(title: "Delete", titleColor: UIColor.CT_25,
                                          font: UIFont.main(.bold, size: 13))
    
    override func setupView() {
        let view = UIMaker.makeView()
        view.addSubviews(views: avatarImgView, nameLabel, mealCountLabel, deleteButton)
        avatarImgView.left(toView: view)
        avatarImgView.vertical(toView: view)
        let avatarHeight: CGFloat = 44
        avatarImgView.square(edge: avatarHeight)
        avatarImgView.setCorner(radius: avatarHeight / 2)
        
        nameLabel.bottom(toAnchor: view.centerYAnchor, space: -2)
        nameLabel.leftHorizontalSpacing(toView: avatarImgView, space: -16)
        
        mealCountLabel.left(toView: nameLabel)
        mealCountLabel.verticalSpacing(toView: nameLabel, space: 4)
        
        deleteButton.right(toView: view)
        deleteButton.centerY(toView: view)
        
        addSubviews(views: view)
        view.horizontal(toView: self, space: padding)
        view.top(toView: self)
    }
}
