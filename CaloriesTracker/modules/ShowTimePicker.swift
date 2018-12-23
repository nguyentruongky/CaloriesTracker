//
//  ShowTimePicker.swift
//  invo-ios
//
//  Created by Ky Nguyen Coinhako on 11/26/18.
//  Copyright © 2018 kynguyen. All rights reserved.
//

import UIKit

class knTimeSlot: knGridCell<String> {
    override var data: String? { didSet {
        timeLabel.text = data
    }}
    let timeLabel = UIMaker.makeLabel(font: UIFont.main(.regular, size: 14),
                                      color: UIColor.CT_170,
                                      alignment: .center)
    override func setupView() {
        addSubviews(views: timeLabel)
        timeLabel.fill(toView: self)
        setCorner(radius: 5)
        setBorder(1, color: UIColor.CT_170)
    }
    
    override var isSelected: Bool { didSet {
        let color = isSelected ? UIColor.CT_105 : UIColor.CT_170
        setBorder(1, color: color)
        timeLabel.textColor = color
        let font = UIFont.main(isSelected ? .bold : .regular, size: 14)
        timeLabel.font = font
    }}
}

class knTimePicker: knGridView<knTimeSlot, String> {
    override func setupView() {
        lineSpacing = padding
        layout = UICollectionViewFlowLayout()
        layout!.scrollDirection = .horizontal
        itemSize = CGSize(width: 64, height: 0)
        lineSpacing = 8
        contentInset = UIEdgeInsets(left: padding, right: padding)
        
        super.setupView()
        addSubviews(views: collectionView)
        collectionView.fill(toView: self)
    }
    
    override func didSelectItem(at indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.isSelected = true
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.isSelected = false
    }
}
