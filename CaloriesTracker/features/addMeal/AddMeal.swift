//
//  AddMeal.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/21/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit

class CTAddMealCtr: knGridController<CTFoodCell, CTFood> {
    override func setupView() {
        hidesBottomBarWhenPushed = true
        navigationController?.hideBar(false)
        addBackButton(tintColor: .CT_25)

        layout = UICollectionViewFlowLayout()
        contentInset = UIEdgeInsets.zero
        lineSpacing = 0
        columnSpacing = 0
        let width = (screenWidth) / 2 - 8
        itemSize = CGSize(width: width, height: 250)
        super.setupView()
        collectionView.backgroundColor = UIColor.bg
        view.addSubviews(views: collectionView)
        collectionView.fill(toView: view)
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 8, right: 8)
        fetchData()
    }
    
    override func fetchData() {
        datasource = [
            CTFood(image: "https://choosemyplate-prod.azureedge.net/sites/default/files/styles/food_gallery_colorbox__800x500_/public/myplate/Arugula%20%28Rocket%29_0.jpeg?itok=W7hPcuE6", name: "Arugula (Rocket)"),
            CTFood(image: "https://choosemyplate-prod.azureedge.net/sites/default/files/styles/food_gallery_colorbox__800x500_/public/myplate/Bok%20Choy.jpeg?itok=OpdDc2gC", name: "Bok Choy"),
            CTFood(image: "https://choosemyplate-prod.azureedge.net/sites/default/files/styles/food_gallery_colorbox__800x500_/public/myplate/Broccoli.jpeg?itok=aksUvoGw", name: "Broccoli"),
            CTFood(image: "https://choosemyplate-prod.azureedge.net/sites/default/files/styles/food_gallery_colorbox__800x500_/public/myplate/Broccoli%20Rabe%20%28Rapini%29.jpeg?itok=E2_zIVDO", name: "Broccoli Rabe (Rapini)"),
            CTFood(image: "https://choosemyplate-prod.azureedge.net/sites/default/files/styles/food_gallery_colorbox__800x500_/public/myplate/Broccolini.jpeg?itok=1cRTXcvp", name: "Broccolini"),
            CTFood(image: "https://choosemyplate-prod.azureedge.net/sites/default/files/styles/food_gallery_colorbox__800x500_/public/myplate/Mustard%20Greens.jpeg?itok=AZS-fegE", name: "Mustard Greens"),
            CTFood(image: "https://choosemyplate-prod.azureedge.net/sites/default/files/styles/food_gallery_colorbox__800x500_/public/myplate/Romaine%20Lettuce.jpeg?itok=9f3yq7xG", name: "Romaine Lettuce"),
            CTFood(image: "https://choosemyplate-prod.azureedge.net/sites/default/files/styles/food_gallery_colorbox__800x500_/public/myplate/Spinach.jpeg?itok=_zpTGPI6", name: "Spinach"),
            CTFood(image: "https://choosemyplate-prod.azureedge.net/sites/default/files/styles/food_gallery_colorbox__800x500_/public/myplate/Swiss%20Chard.jpeg?itok=1j5LbikN", name: "Swiss Chard"),
            CTFood(image: "https://choosemyplate-prod.azureedge.net/sites/default/files/styles/food_gallery_colorbox__800x500_/public/myplate/Watercress.jpeg?itok=QqKi3Xyx", name: "Watercress"),
        ]
    }
}
