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
    var data: CTFood?
    
    override func setupView() {
        navigationController?.hideBar(true)
        super.setupView()
        datasource = ui.setupView()
        
        view.addSubviews(views: ui.fixedImgView, tableView)
        tableView.fill(toView: view)
        ui.fixedImgView.top(toView: view)
        ui.fixedImgView.horizontal(toView: view)
        ui.fixedImgView.height(ui.headerHeight)
        ui.fixedImgView.clipsToBounds = true
        
        ui.addSelectButton(to: view)
        
        tableView.backgroundColor = .clear
        ui.backButton = addFakeBackButton()
        
        ui.selectButton.addTarget(self, action: #selector(selectThisFood))
        ui.removeButton.addTarget(self, action: #selector(removeFood))
        
        fetchData()
        
        view.clipsToBounds = true
    }
    
    override func fetchData() {
        guard let data = data else { return }
        let image = data.image
        ui.imgView.downloadImage(from: image)
        ui.fixedImgView.downloadImage(from: image)
        ui.titleLabel.text = data.name
        ui.caloriesLabel.text = "Energy: \(data.calories) KCAL"
        let descriptionCell = ui.makeTextCell(title: "Description", content: data.description)
        var cells = datasource
        cells.append(contentsOf: [descriptionCell])
        datasource = cells
        view.layoutIfNeeded()
        
        guard let controllers = navigationController?.viewControllers else { return }
        for ctr in controllers where ctr is CTAddMealCtr {
            if let isSelected = (ctr as? CTAddMealCtr)?.mealOptionView.meal.foods.contains(data) {
                ui.removeButton.isHidden = !isSelected
            }
            break
        }
    }
    
    @objc func selectThisFood() {
        guard let data = data else { return }
        guard let controllers = navigationController?.viewControllers else { return }
        for ctr in controllers where ctr is CTAddMealCtr {
            (ctr as? CTAddMealCtr)?.selectFood(data)
            break
        }
        
        ui.removeButton.isHidden = false
    }
    
    @objc func removeFood() {
        guard let data = data else { return }
        guard let controllers = navigationController?.viewControllers else { return }
        for ctr in controllers where ctr is CTAddMealCtr {
            (ctr as? CTAddMealCtr)?.removeFood(data)
            break
        }
        
        ui.removeButton.isHidden = true
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
