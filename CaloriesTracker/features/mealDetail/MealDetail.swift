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
        
    }}
    let ui = UI()
    
    override func setupView() {
        addBackButton()
        tableView.backgroundColor = UIColor.bg
        navigationController?.hideBar(false)
        title = "Breakfast"
        super.setupView()
        datasource = ui.setupView()
        view.addSubviews(views: ui.fixedImgView, tableView)
        tableView.fill(toView: view)
        ui.fixedImgView.top(toView: view)
        ui.fixedImgView.horizontal(toView: view)
        ui.fixedImgView.height(ui.headerHeight)
        
        fetchData()
    }
    
    override func fetchData() {
        let imgUrl = "https://imagesvc.timeincapp.com/v3/mm/image?url=https%3A%2F%2Fimg1.cookinglight.timeinc.net%2Fsites%2Fdefault%2Ffiles%2Fstyles%2F4_3_horizontal_-_1200x900%2Fpublic%2Fimage%2F2017%2F03%2Fmain%2Fspinach-pesto-pasta-shrimp_0_1_0.jpg%3Fitok%3DiEn-0uVj%261530126200&w=1000&c=sc&poi=face&q=70"
        ui.titleLabel.text = "Peppery Shrimp with Grits and Greens"
        ui.imgView.downloadImage(from: imgUrl)
        ui.fixedImgView.downloadImage(from: imgUrl)
        ui.caloriesLabel.text = "270 KCAL"
        ui.attentionView.backgroundColor = UIColor.CT_254_196_68
        ui.messageLabel.text = "Standard"
        ui.timeLabel.text = "12:00 - Dec 24, 2018"
        ui.noteLabel.text = "The best weeknight dinners don't require special cooking skills or out-of-the-ordinary ingredients, yet are still delicious and nourishing. "
        ui.ateFoodView.datasource = [
            CTFood(image: imgUrl, name: "Arugula (Rocket)")
        ]
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
