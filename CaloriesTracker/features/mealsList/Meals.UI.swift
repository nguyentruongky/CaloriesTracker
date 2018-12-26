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
        let upcomingContainer = UIMaker.makeStackView(space: 32)
        let previousLabel = UIMaker.makeLabel(text: "PREVIOUS MEALS",
                                              font: UIFont.main(.bold, size: 15), color: .CT_25)
        let stateView = knStateView()
        lazy var stateWrapper = makeStateView()
        lazy var greetingView = makeGreetingView()
        lazy var upcomingCell = makeUpcomingCell()
        
        func makeGreetingView() -> UIView {
            let bg = UIMaker.makeImageView()
            bg.backgroundColor = UIColor.main
            let name = appSetting.user?.name ?? ""
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
            cell.addSubviews(views: upcomingContainer)
            upcomingContainer.horizontal(toView: cell)
            upcomingContainer.top(toView: cell, space: padding)
            let topViewBottom = upcomingContainer.bottom(toView: cell, space: -12, isActive: false)
            topViewBottom.priority = UILayoutPriority(rawValue: 999)
            topViewBottom.isActive = true 
            return cell
        }
        
        func setUpcomingView(visible: Bool) {
            if visible {
                upcomingContainer.insertArrangedSubview(upcomingMealsView, at: 0)
                upcomingMealsView.height(400)
                upcomingMealsView.horizontal(toView: upcomingContainer)
            } else {
                upcomingMealsView.removeFromSuperview()
                upcomingMealsView.removeAllConstraints()
            }
        }
        
        func setPreviousMealLabel(visible: Bool) {
            if visible {
                upcomingContainer.insertArrangedSubview(previousLabel, at: upcomingContainer.subviews.count)
                previousLabel.left(toView: upcomingContainer, space: padding)
            } else {
                upcomingMealsView.removeFromSuperview()
            }
        }
        
        func setupView(_ view: UIView) {
            view.addSubviews(views: greetingView)
            greetingView.horizontal(toView: view)
            greetingView.top(toView: view)
            greetingView.height(170)
        }
        
        func makeStateView() -> UIView {
            let view = UIMaker.makeView()
            let greetingView = makeGreetingView()
            view.addSubviews(views: stateView, greetingView)
            view.addConstraints(withFormat: "V:|-44-[v0]-(-24)-[v1]|", views: greetingView, stateView)
            greetingView.horizontal(toView: view)
            greetingView.height(170)
            
            stateView.horizontal(toView: view)
            return view
        }
    }
}
