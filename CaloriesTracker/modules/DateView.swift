//
//  DateView.swift
//  invo-ios
//
//  Created by Ky Nguyen Coinhako on 11/26/18.
//  Copyright © 2018 kynguyen. All rights reserved.
//

import UIKit

struct knDate {
    var day: Int
    var date: Date
    var dayOfWeek: String
    var selected = false
    init(date: Date) {
        self.date = date
        day = date.day
        dayOfWeek = date.dayOfTheWeek.substring(to: 3)
    }
}

class knDateCell: knGridCell<knDate> {
    override var data: knDate? { didSet {
        guard let data = data else { return }
        dayOfWeekLabel.text = data.dayOfWeek
        dayLabel.text = String(data.day)
    }}
    let dayOfWeekLabel = UIMaker.makeLabel(font: UIFont.main(.regular, size: 14),
                                      color: UIColor.CT_170,
                                      alignment: .center)
    let dayLabel = UIMaker.makeLabel(font: UIFont.main(.medium, size: 20),
                                           color: UIColor.CT_170,
                                           alignment: .center)
    let selectedBar = UIMaker.makeHorizontalLine(color: UIColor.CT_105, height: 2)
    override func setupView() {
        addSubviews(views: dayOfWeekLabel, dayLabel, selectedBar)
        addConstraints(withFormat: "V:|-8-[v0]-4-[v1]-16-[v2]|",
                       views: dayOfWeekLabel, dayLabel, selectedBar)
        dayOfWeekLabel.centerX(toView: self)
        dayLabel.centerX(toView: self)
        selectedBar.horizontal(toView: self)
        selectedBar.isHidden = true
    }
    
    override var isSelected: Bool { didSet {
        selectedBar.isHidden = !isSelected
        let color = isSelected ? UIColor.CT_105 : UIColor.CT_170
        dayOfWeekLabel.textColor = color
        dayLabel.textColor = color
    }}
}

class knDateView: knGridView<knDateCell, knDate> {
    var selectedIndex: IndexPath?
    
    override func setupView() {
        lineSpacing = padding
        layout = UICollectionViewFlowLayout()
        layout!.scrollDirection = .horizontal
        itemSize = CGSize(width: 64, height: 0)
        lineSpacing = 8
        contentInset = UIEdgeInsets(left: 8, right: 8)
        
        super.setupView()
        addSubviews(views: collectionView)
        collectionView.fill(toView: self)
        
        let line = UIMaker.makeHorizontalLine(color: UIColor.CT_222, height: 1)
        addSubviews(views: line)
        line.horizontal(toView: self)
        line.bottom(toView: self)
    }
    
    override func didSelectItem(at indexPath: IndexPath) {
        if let selected = selectedIndex {
            let cell = collectionView.cellForItem(at: selected)
            cell?.isSelected = false
        }
        
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.isSelected = true
        
        selectedIndex = indexPath
    }
}

