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
        let upcomingMealsView = CTUpcomingMealsView()
        let upcomingStack = UIMaker.makeStackView(space: 32)
        let previousLabel = UIMaker.makeLabel(text: "PREVIOUS MEALS",
                                              font: UIFont.main(.bold, size: 15), color: .CT_25)
        let stateView = knStateView()
        lazy var stateWrapper = makeStateView()
        lazy var greetingView = makeGreetingView()
        lazy var upcomingCell = makeUpcomingCell()
        lazy var filterButton = makeFilterButton()
        
        func makeGreetingView() -> UIView {
            let bg = UIMaker.makeImageView()
            bg.backgroundColor = UIColor.main
            let name = appSetting.userName ?? ""
            let hello = "Hello" + (name == "" ? "" : " " + name)
            let greetingLabel = UIMaker.makeLabel(text: "\(hello), what would you like to eat?",
                                                  font: UIFont.main(.medium, size: 15),
                                                  color: .white, alignment: .center)
            let addButton = UIMaker.makeMainButton(title: "Add meals",
                                                   bgColor: .white, titleColor: .main)
            addButton.tag = 1001
            let view = UIMaker.makeView()
            view.addSubviews(views: bg, greetingLabel, addButton)
            
            bg.centerX(toView: view)
            bg.centerY(toAnchor: view.topAnchor, space: -320)
            let edge: CGFloat = 1000
            bg.square(edge: edge)
            bg.setCorner(radius: edge / 2)
            
            greetingLabel.horizontal(toView: view, space: padding)
            greetingLabel.top(toView: view, space: padding)
            
            addButton.horizontal(toView: view, space: padding)
            addButton.verticalSpacing(toView: greetingLabel, space: padding)            
            return view
        }
        
        func makeUpcomingCell() -> knTableCell {
            let cell = knTableCell()
            cell.backgroundColor = .bg
            cell.addSubviews(views: upcomingStack)
            upcomingStack.horizontal(toView: cell)
            upcomingStack.top(toView: cell, space: padding)
            let topViewBottom = upcomingStack.bottom(toView: cell, space: -12, isActive: false)
            topViewBottom.priority = UILayoutPriority(rawValue: 999)
            topViewBottom.isActive = true 
            return cell
        }
        
        func setUpcomingView(visible: Bool) {
            if visible {
                upcomingStack.insertArrangedSubview(upcomingMealsView, at: 0)
                upcomingMealsView.height(400)
                upcomingMealsView.horizontal(toView: upcomingStack)
            } else {
                upcomingMealsView.removeFromSuperview()
            }
        }
        
        func setPreviousMealLabel(visible: Bool) {
            if visible {
                upcomingStack.insertArrangedSubview(previousLabel, at: upcomingStack.subviews.count)
                previousLabel.left(toView: upcomingStack, space: padding)
            } else {
                previousLabel.removeFromSuperview()
            }
        }
            
        func makeStateView() -> UIView {
            stateView.setStateContent(state: .empty, imageName: "no_meal", title: "You have no meal", content: "Start tracking your calories everyday by adding meals")
            
            let view = UIMaker.makeView()
            let greetingView = makeGreetingView()
            view.addSubviews(views: stateView, greetingView)
            view.addConstraints(withFormat: "V:|-44-[v0]-(-24)-[v1]|", views: greetingView, stateView)
            greetingView.horizontal(toView: view)
            greetingView.height(170)
            
            stateView.horizontal(toView: view)
            return view
        }
        
        func makeFilterButton() -> UIButton {
            let button = UIMaker.makeButton(image: UIImage(named: "filter"))
            button.backgroundColor = .white
            button.setBorder(1, color: UIColor.gray)
            let edge: CGFloat = 44
            button.square(edge: edge)
            button.setCorner(radius: edge / 2)
            button.contentEdgeInsets = UIEdgeInsets(space: 12)
            return button
        }
    }
}
