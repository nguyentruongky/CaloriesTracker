//
//  Meals.UI.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/21/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit

extension CTMealsDashboard {
    class UI {
        let thisWeekView = ThisWeekView()
        let mealLabel = UIMaker.makeLabel(text: "PREVIOUS MEALS",
                                              font: UIFont.main(.bold, size: 15), color: .CT_25)
        let addButton = UIMaker.makeMainButton(title: "Add meal", bgColor: UIColor.green)

        func makeHeaderView() -> UIView {
            let bg = UIMaker.makeImageView()
            bg.backgroundColor = UIColor.main
            let greetingLabel = UIMaker.makeLabel(text: "What would you like to eat?",
                                                  font: UIFont.main(.medium, size: 15),
                                                  color: .white, alignment: .center)
            let thisWeekLabel = UIMaker.makeLabel(text: "THIS WEEK",
                                                  font: UIFont.main(.bold, size: 15), color: .CT_25)
            let view = UIMaker.makeView()
            view.addSubviews(views: bg, greetingLabel, addButton, thisWeekLabel, thisWeekView, mealLabel)
            
            bg.centerX(toView: view)
            bg.centerY(toAnchor: view.topAnchor, space: -320)
            let edge: CGFloat = 1000
            bg.square(edge: edge)
            bg.setCorner(radius: edge / 2)
            
            greetingLabel.horizontal(toView: view, space: padding)
            greetingLabel.top(toView: view, space: padding)

            addButton.horizontal(toView: view, space: padding)
            addButton.verticalSpacing(toView: greetingLabel, space: padding)
            
            view.addConstraints(withFormat: "V:|-\(padding * 8)-[v0]-16-[v1]-32-[v2]", views: thisWeekLabel, thisWeekView, mealLabel)
            thisWeekLabel.left(toView: view, space: padding)
            mealLabel.left(toView: thisWeekLabel)
            
            thisWeekView.horizontal(toView: view)
            thisWeekView.height(400)
            
            return view
        }
    }
}

