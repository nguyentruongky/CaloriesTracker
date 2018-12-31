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
    
    private let ui = UI()
    private let menus: [Menu] = [.profile, .calories, .logout]
    private var actions = [Menu: (() -> Void)]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hideBar(false)
    }
    
    override func setupView() {
        navigationItem.title = "SETTINGS"
        rowHeight = 66
        super.setupView()
        view.addFill(tableView)
        contentInset = UIEdgeInsets(top: 16)
        datasource = ui.setupView()
        
        actions[.logout] = askLogoutConfirmation
        actions[.calories] = changeCalories
        actions[.profile] = showMyProfile
    }
    
    private func askLogoutConfirmation() {
        let ctr = CTMessage.showMessage("Are you sure you want to logout?", title: "Confirm logout", cancelActionName: "Cancel")
        ctr.addAction(UIAlertAction(title: "Log out", style: .default, handler: { _ in
            CTLogoutWorker().execute()
            let loginCtr = CTLoginCtr()
            UIApplication.present(wrap(loginCtr))
        }))
        
        present(ctr)
    }
    
    private func changeCalories() {
        let ctr = CTCaloriesCtr()
        ctr.hidesBottomBarWhenPushed = true
        push(ctr)
    }
    
    private func showMyProfile() {
        let ctr = CTUserProfileCtr()
        ctr.isMyProfile = true
        ctr.data = appSetting.user
        ctr.hidesBottomBarWhenPushed = true
        push(ctr)
    }
    
    override func didSelectRow(at indexPath: IndexPath) {
        let key = menus[indexPath.row]
        let action = actions[key]
        action?()
    }
}
