//
//  Boss.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/20/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit

var boss: CTBigBoss?
class CTBigBoss: UITabBarController, UITabBarControllerDelegate {
    let mealsCtr = CTMealsDashboard()
    let settingCtr = CTSettingCtr()
    var usersCtr: CTUserList!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        boss = self
        delegate = self
        selectedIndex = 0
    }
    
    func setupView() {
        let wrappedMeal = wrap(mealsCtr)
        let wrappedSetting = wrap(settingCtr)
        
        if appSetting.userRole == .admin || appSetting.userRole == .manager {
            usersCtr = CTUserList()
            let wrapUsers = wrap(usersCtr)
            viewControllers = [
                wrappedMeal,
                wrapUsers,
                wrappedSetting
            ]
            setTabItem(wrapUsers.tabBarItem, image: UIImage(named: "users_list"), title: "Users")
        } else {
            viewControllers = [
                wrappedMeal,
                wrappedSetting
            ]
        }
        
        setTabItem(wrappedMeal.tabBarItem, image: UIImage(named: "meals"), title: "Meals")
        setTabItem(wrappedSetting.tabBarItem, image: UIImage(named: "setting"), title: "Settings")
        
        tabBar.barTintColor = UIColor(r: 252, g: 61, b: 86)
        tabBar.tintColor = .white
        
        UITabBarItem.appearance().setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont.main(size: 12)], for: .normal)
    }
    
    func setTabItem(_ item: UITabBarItem, image: UIImage?, title: String) {
        item.image = image
        item.title = title
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        fade(from: selectedViewController, to: viewController)
        return true
    }
    
    func fade(from fromController: UIViewController?, to toController: UIViewController?) {
        if fromController == nil || toController == fromController { return }
        
        guard let selectView = (selectedViewController as? UINavigationController)?.viewControllers.first?.view,
            let newView = (toController as? UINavigationController)?.viewControllers.first?.view else { return }
        
        let fromView = selectView
        let toView = newView
        
        UIView.transition(from: fromView, to: toView, duration: 0.35, options: [.transitionCrossDissolve], completion: nil)
    }
}



