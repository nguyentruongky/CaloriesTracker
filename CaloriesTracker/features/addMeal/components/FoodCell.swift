//
//  IngredientCell.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/21/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit

class CTFood: Equatable {
    static func == (lhs: CTFood, rhs: CTFood) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id: Int?
    var image: String?
    var name: String?
    var calories = 0
    var description: String?
    var ingredient: String?

    init(raw: AnyObject) {
        id = raw["id"] as? Int
        name = raw["title"] as? String
        description = raw["description"] as? String
        ingredient = raw["ingredient"] as? String
        calories = raw["calories"] as? Int ?? 0
        if let images = raw["images"] as? [String] {
            image = images.first
        }
    }
    
    func toDict() -> [String: Any?] {
        var dict = [String: Any?]()
        dict["id"] = id
        dict["title"] = name
        dict["description"] = description
        dict["ingredient"] = ingredient
        dict["calories"] = calories
        if let imageUrl = image {
            dict["images"] = [imageUrl]
        }
        
        return dict
    }
}

class CTFoodCell: knGridCell<CTFood> {
    override var data: CTFood? { didSet {
        guard let data = data else { return }
        imgView.downloadImage(from: data.image, placeholder: UIImage(named: "meal_placeholder"))
        nameLabel.text = data.name
        
        guard let foods = parent?.mealOptionView.meal.foods else { return }
        removeButton.isHidden = !foods.contains(data)
    }}
    weak var parent: CTAddMealCtr?
    
    private let imgView = UIMaker.makeImageView(image: UIImage(named: "meal_placeholder"),
                                        contentMode: .scaleAspectFill)
    private let nameLabel = UIMaker.makeLabel(font: UIFont.main(size: 13),
                                      color: UIColor.CT_25, alignment: .center)
    private let selectButton = UIMaker.makeButton(title: "Select", titleColor: UIColor.CT_25,
                                          font: UIFont.main(.bold, size: 13))
    private let removeButton = UIMaker.makeButton(title: "Remove", titleColor: .white,
                                          font: UIFont.main(.bold, size: 13),
                                          background: .main)
    
    override func setupView() {
        let view = UIMaker.makeView(background: .white)
        let line = UIMaker.makeHorizontalLine(color: UIColor.CT_222, height: 0.75)
        view.addSubviews(views: imgView, nameLabel, line, selectButton, removeButton)
        view.addConstraints(withFormat: "V:|[v0]-16-[v1]-8-[v2][v3]|", views: imgView, nameLabel, line, selectButton, removeButton)
        imgView.horizontal(toView: view)
        nameLabel.height(24)
        nameLabel.horizontal(toView: view, space: 8)
        line.horizontal(toView: view)
        selectButton.horizontal(toView: view)
        selectButton.height(36)
        
        removeButton.fill(toView: selectButton)
        removeButton.isHidden = true
        
        view.setCorner(radius: 7)
        addSubviews(views: view)
        view.fill(toView: self, space: UIEdgeInsets(space: 8))
        view.setBorder(0.5, color: UIColor.CT_222)
        
        selectButton.addTarget(self, action: #selector(selectThisFood))
        removeButton.addTarget(self, action: #selector(removeThisFood))
    }
    
    @objc func selectThisFood() {
        guard let data = data else { return }
        parent?.selectFood(data)
        removeButton.isHidden = false
    }
    
    @objc func removeThisFood() {
        guard let data = data else { return }
        parent?.removeFood(data)
        removeButton.isHidden = true
    }
}
