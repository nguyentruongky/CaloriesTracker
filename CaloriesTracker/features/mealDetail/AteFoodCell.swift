//
//  FoodCell.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/23/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit

final class CTAteFoodView: knGridView<CTAteFoodCell, CTFood> {
    override func setupView() {
        let edge: CGFloat = 200
        lineSpacing = padding
        layout = UICollectionViewFlowLayout()
        layout?.scrollDirection = .horizontal
        itemSize = CGSize(width: edge, height: 0)
        let leftSpacing: CGFloat = padding
        contentInset = UIEdgeInsets(left: leftSpacing, right: leftSpacing)
        
        super.setupView()
        collectionView.backgroundColor = .clear
        addSubviews(views: collectionView)
        collectionView.fill(toView: self, space: UIEdgeInsets(bottom: 24))
    }
}

final class CTAteFoodCell: knGridCell<CTFood> {
    override var data: CTFood? { didSet {
        nameLabel.text = data?.name
        imgView.downloadImage(from: data?.image)
    }}
    let nameLabel = UIMaker.makeLabel(font: UIFont.main(.regular, size: 14),
                                      color: UIColor.CT_25, alignment: .center)
    let imgView = UIMaker.makeImageView(contentMode: .scaleAspectFill)
    
    override func setupView() {
        let view = UIMaker.makeView(background: .white)
        view.clipsToBounds = true
        view.setCorner(radius: 7)

        view.addSubviews(views: nameLabel, imgView)
        view.addConstraints(withFormat: "V:|[v0]-16-[v1]-16-|", views: imgView, nameLabel)
        imgView.height(120)
        imgView.horizontal(toView: view)
        nameLabel.horizontal(toView: view)
        
        addSubviews(views: view)
        view.horizontal(toView: self)
        view.centerY(toView: self)
    }
}








