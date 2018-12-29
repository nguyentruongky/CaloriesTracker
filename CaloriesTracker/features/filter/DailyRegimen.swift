//
//  DailyRegimen.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/27/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit


struct CTRegimen {
    var text: String
    var selected = false
    init(text: String) {
        self.text = text
    }
}

class CTRegimenCell: knGridCell<CTRegimen> {
    override var data: CTRegimen? { didSet {
        guard let data = data else { return }
        contentLabel.text = data.text
        checkSelected = data.selected
    }}
    let contentLabel = UIMaker.makeLabel(font: UIFont.main(.medium, size: 13),
                                      color: UIColor.CT_170,
                                      alignment: .center)
    private let view = UIMaker.makeView()
    override func setupView() {
        view.addSubviews(views: contentLabel)
        let vSpace: CGFloat = 8
        let hSpace: CGFloat = 10
        contentLabel.fill(toView: view, space: UIEdgeInsets(top: vSpace, left: hSpace, bottom: vSpace, right: hSpace))
        view.setCorner(radius: 7)
        view.setBorder(1, color: UIColor.CT_170)
        
        addSubviews(views: view)
        view.horizontal(toView: self)
        view.centerY(toView: self)
    }
    
    private var checkSelected: Bool = false { didSet {
        contentLabel.textColor = checkSelected ? .white : .CT_25
        view.backgroundColor = checkSelected ? .main : .white
        view.setBorder(checkSelected ? 0 : 1, color: .CT_222)
    }}
}

class CTRegimenView: knGridView<CTRegimenCell, CTRegimen> {
    override func setupView() {
        lineSpacing = padding
        layout = UICollectionViewFlowLayout()
        layout!.scrollDirection = .horizontal
        itemSize = CGSize(width: 64, height: 0)
        columnSpacing = 8
        
        super.setupView()
        addSubviews(views: collectionView)
        collectionView.fill(toView: self)
        
        collectionView.allowsMultipleSelection = true
    }
    
    override func didSelectItem(at indexPath: IndexPath) {
        datasource[indexPath.row].selected = !datasource[indexPath.row].selected
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cell = CTRegimenCell()
        cell.contentLabel.text = datasource[indexPath.row].text
        cell.contentLabel.sizeToFit()
        let size = cell.contentLabel.frame.size
        return CGSize(width: size.width + 20, height: size.height + 16)
    }
}
