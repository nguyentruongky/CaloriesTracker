//
//  IngredientCell.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/21/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit

class CTFood {
    var id: Int?
    var image: String?
    var name: String?
    var calories = 0
    var description: String?
    var ingredient: String?
    
    init(id: Int) {
        self.id = id
    }
    
    init(image: String, name: String) {
        self.image = image
        self.name = name
    }
    
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
        imgView.downloadImage(from: data?.image)
        nameLabel.text = data?.name
    }}
    weak var parent: CTAddMealCtr?
    
    let imgView = UIMaker.makeImageView(contentMode: .scaleAspectFill)
    let nameLabel = UIMaker.makeLabel(font: UIFont.main(size: 13),
                                      color: UIColor.CT_25, alignment: .center)
    let selectButton = UIMaker.makeButton(title: "Select", titleColor: UIColor.CT_25,
                                          font: UIFont.main(.bold, size: 13))
    
    override func setupView() {
        let view = UIMaker.makeView(background: .white)
        let line = UIMaker.makeHorizontalLine(color: UIColor.CT_222, height: 0.75)
        view.addSubviews(views: imgView, nameLabel, line, selectButton)
        view.addConstraints(withFormat: "V:|[v0]-16-[v1]-8-[v2][v3]|", views: imgView, nameLabel, line, selectButton)
        imgView.horizontal(toView: view)
        nameLabel.height(24)
        nameLabel.horizontal(toView: view, space: 8)
        line.horizontal(toView: view)
        selectButton.horizontal(toView: view)
        selectButton.height(36)
        
        view.setCorner(radius: 7)
        addSubviews(views: view)
        view.fill(toView: self, space: UIEdgeInsets(space: 8))
        view.setBorder(0.5, color: UIColor.CT_222)
        
        selectButton.addTarget(self, action: #selector(selectThisFood))
    }
    
    func makeButton(_ text: String) -> UIButton {
        return UIMaker.makeButton(title: text, titleColor: .CT_25,
                           font: UIFont.main(.bold, size: 15),
                           background: .white, cornerRadius: 18,
                           borderWidth: 1, borderColor: .lightGray)
    }
    
    @objc func selectThisFood() {
        guard let data = data else { return }
        parent?.selectFood(data: data)
    }
}
