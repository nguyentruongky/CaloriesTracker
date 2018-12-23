//
//  FoodDetail.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/23/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit
class CTFoodDetailCtr: knStaticListController {
    let ui = UI()
    var data: CTFood? { didSet {
        guard let data = data else { return }
        let image = data.image
        ui.imgView.downloadImage(from: image)
        ui.fixedImgView.downloadImage(from: image)
        ui.titleLabel.text = data.name
        ui.caloriesLabel.text = String(data.calorie)
        let descriptionCell = ui.makeTextCell(title: "Description", content: data.description)
        let ingredientCell = ui.makeTextCell(title: "INGREDIENT", content: data.ingredient)
        datasource.append(contentsOf: [descriptionCell, ingredientCell])
    }}
    
    override func setupView() {
        navigationController?.hideBar(true)
        super.setupView()
        datasource = ui.setupView()
        
        view.addSubviews(views: ui.fixedImgView, tableView)
        tableView.fill(toView: view)
        ui.fixedImgView.top(toView: view)
        ui.fixedImgView.horizontal(toView: view)
        ui.fixedImgView.height(ui.headerHeight)
        
        ui.addSelectButton(to: view)
        
        
        tableView.backgroundColor = .clear
        ui.backButton = addFakeBackButton()
    }
    
    func addFakeBackButton() -> UIButton {
        let button = UIMaker.makeButton(image: UIImage(named: "back_arrow")?.changeColor())
        button.imageView?.changeColor(to: UIColor.CT_25)
        button.addTarget(self, action: #selector(back))
        button.contentVerticalAlignment = .top
        button.contentEdgeInsets = UIEdgeInsets(space: 12)
        view.addSubviews(views: button)
        button.square(edge: 44)
        button.setCorner(radius: 22)
        button.backgroundColor = .white
        button.topLeft(toView: view, top: hasNotch() ? 44 : 20, left: 8)
        return button
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hideBar(true)
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
        ui.backButton.isHidden = yOffset > 20
        isStatusBarHidden = yOffset > 20
    }
}
