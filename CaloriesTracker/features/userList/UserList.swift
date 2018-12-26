//
//  UserList.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/24/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit
class CTUserList: knListController<CTUserCell, CTUserDetail> {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hideBar(false)
    }
    override func setupView() {
        navigationItem.title = "USERS"
        rowHeight = 72
        contentInset = UIEdgeInsets(top: padding, bottom: padding)
        super.setupView()
        view.addFill(tableView)
        
        fetchData()
    }
    
    override func fetchData() {
        let user = CTUser(name: "Steve Harley", avatar: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0a/SteveHarveyHWOFMay2013.jpg/250px-SteveHarveyHWOFMay2013.jpg")
        datasource = [
            CTUserDetail(user: user, mealCount: 6),
            CTUserDetail(user: user, mealCount: 6),
            CTUserDetail(user: user, mealCount: 6),
            CTUserDetail(user: user, mealCount: 6),
            CTUserDetail(user: user, mealCount: 6),
            CTUserDetail(user: user, mealCount: 6),
            CTUserDetail(user: user, mealCount: 6),
            CTUserDetail(user: user, mealCount: 6),
        ]
    }
}



