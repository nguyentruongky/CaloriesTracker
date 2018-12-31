//
//  Filter.UI.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/27/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit

extension CTFilterCtr {
    class UI {
        let fromButton = UIMaker.makeButton(title: "Select", titleColor: .CT_170,
                                            font: UIFont.main(.bold, size: 17))
        let toButton = UIMaker.makeButton(title: "Select", titleColor: .CT_170,
                                            font: UIFont.main(.bold, size: 17))
        let regimenView = CTRegimenView()
        let applyButton = UIMaker.makeMainButton(title: "Go")
        
        let datePicker = knPickerView.make(startDate: Date())
        func setupView() -> [knTableCell] {
            fromButton.contentHorizontalAlignment = .left
            toButton.contentHorizontalAlignment = .left
            regimenView.height(48)
            datePicker.changeDateMode(mode: .dateAndTime)
            datePicker.changeMinuteInterval(minutes: 15)
            
            return [
                makeSelectionCell(contentView: fromButton, title: "From date/time"),
                makeSelectionCell(contentView: toButton, title: "To date/time"),
                makeSelectionCell(contentView: regimenView, title: "Daily regimen"),
                makeButtonCell(),
            ]
        }
        
        private func makeTitleLabel(title: String) -> UILabel {
            return UIMaker.makeLabel(text: title, font: UIFont.main(.medium, size: 13), color: .CT_25)
        }
        
        private func makeSelectionCell(contentView: UIView, title: String) -> knTableCell {
            let label = makeTitleLabel(title: title)
            let cell = knTableCell()
            cell.addSubviews(views: contentView, label)
            cell.addConstraints(withFormat: "V:|[v0]-4-[v1]-\(padding)-|", views: label, contentView)
            label.left(toView: cell, space: padding)
            contentView.horizontal(toView: cell, space: padding)
            return cell
        }
        
        private func makeButtonCell() -> knTableCell {
            let cell = knTableCell()
            cell.addSubviews(views: applyButton)
            applyButton.fill(toView: cell, space: UIEdgeInsets(space: padding))
            return cell
        }
    }
}

