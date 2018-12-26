//
//  Setting.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/25/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit


class CTSettingCtr: knStaticListController {
    enum Menu: String {
        case profile, calories, logout
    }
    
    let ui = UI()
    let menus: [Menu] = [.profile, .calories, .logout]
    var actions = [Menu: (() -> Void)]()
    
    override func setupView() {
        title = "SETTINGS"
        rowHeight = 66
        super.setupView()
        view.addFill(tableView)
        contentInset = UIEdgeInsets(top: 16)
        datasource = ui.setupView()
        
        actions[Menu.logout] = askLogoutConfirmation
        actions[Menu.calories] = changeCalories
    }
    
    func askLogoutConfirmation() {
        let ctr = CTMessage.showMessage("Are you sure you want to logout?", title: "Confirm logout", cancelActionName: "Cancel")
        ctr.addAction(UIAlertAction(title: "Log out", style: .default, handler: { _ in
            CTLogoutWorker().execute()
            appSetting.didLogin = false
            let loginCtr = CTLoginCtr()
            UIApplication.present(wrap(loginCtr))
        }))
        
        present(ctr)
    }
    
    func changeCalories() {
        let ctr = CTCaloriesCtr()
        ctr.hidesBottomBarWhenPushed = true
        push(ctr)
    }
    
    override func didSelectRow(at indexPath: IndexPath) {
        let key = menus[indexPath.row]
        let action = actions[key]
        action?()
    }
}
