//
//  ShowTimePicker.swift
//  invo-ios
//
//  Created by Ky Nguyen Coinhako on 11/26/18.
//  Copyright © 2018 kynguyen. All rights reserved.
//

import UIKit

struct knTime {
    var time: String
    var selected = false
    init(time: String) {
        self.time = time
    }
}

class knTimeSlot: knGridCell<knTime> {
    override var data: knTime? { didSet {
        guard let data = data else { return }
        timeLabel.text = data.time
        isSelected = data.selected
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

class knTimePicker: knGridView<knTimeSlot, knTime> {
    override var datasource: [knTime] { didSet {
        collectionView.reloadData()
        }}
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
        let cell = getCell(at: indexPath)
        cell.isSelected = true
        selectedIndex = indexPath
    }
}
