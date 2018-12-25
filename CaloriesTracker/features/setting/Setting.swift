//
//  Setting.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/25/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit

class CTSettingCtr: knStaticListController {
    let ui = UI()
    override func setupView() {
        title = "SETTINGS"
        rowHeight = 66
        super.setupView()
        view.addFill(tableView)
        contentInset = UIEdgeInsets(top: 16)
        datasource = ui.setupView()
    }
}
