//
//  MealDetail.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/23/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit
class CTMealDetailCtr: knStaticListController {
    var data: CTMeal? { didSet {
        guard let data = data else { return }
        
        ui.titleLabel.text = data.name
        let imgUrl = data.images.first
        ui.imgView.downloadImage(from: imgUrl)
        ui.fixedImgView.downloadImage(from: imgUrl)
        let calories = data.calories.or(0)
        ui.caloriesLabel.text = "\(calories) KCAL"
        title = data.getMealTypeString().uppercased()
        
        if let calories = data.calories {
            let caloriesSet = CaloriesTracker().check(calories: calories)
            ui.attentionView.backgroundColor = caloriesSet.bgColor
            ui.messageLabel.text = caloriesSet.message
            ui.messageLabel.textColor = caloriesSet.textColor
        }
        
        if let date = data.date, let time = data.time {
            ui.timeLabel.text = time + " - " + date
        } else {
            ui.timeLabel.removeFromSuperview()
        }
        
        if let note = data.note {
            ui.noteLabel.text = note
        } else {
            ui.noteLabel.removeFromSuperview()
        }
        
        ui.ateFoodView.datasource = data.foods
    }}
    let ui = UI()
    
    override func setupView() {
        addBackButton()
        tableView.backgroundColor = UIColor.bg
        navigationController?.hideBar(false)
        super.setupView()
        datasource = ui.setupView()
        view.addSubviews(views: tableView, ui.fixedImgView)
        tableView.fill(toView: view)
        
        ui.fixedImgView.top(toView: view)
        ui.fixedImgView.horizontal(toView: view)
        ui.fixedImgView.height(ui.headerHeight)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var headerTransform = CATransform3DIdentity
        let yOffset = scrollView.contentOffset.y
        let staticView = ui.imgView
        let animatedView = ui.fixedImgView
        staticView.isHidden = yOffset < 0
        animatedView.isHidden = yOffset > 0
        if yOffset < 0 {
            let headerScaleFactor:CGFloat = -(yOffset) / animatedView.bounds.height
            let headerSizevariation = ((animatedView.bounds.height * (1.0 + headerScaleFactor)) - animatedView.bounds.height)/2.0
            headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation, 0)
            headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0)
            animatedView.layer.transform = headerTransform
        }
        isStatusBarHidden = yOffset > 20
    }
}
