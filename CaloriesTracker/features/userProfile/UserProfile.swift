//
//  UserProfile.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/24/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit
class CTUserProfileCtr: knListController<CTMealCell, CTMeal> {
    let ui = UI()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hideBar(true)
    }
    
    override func setupView() {
        rowHeight = 244
        super.setupView()
        tableView.backgroundColor = .bg
        let headerView = ui.makeHeaderView()
        view.addSubviews(views: headerView, tableView)
        headerView.horizontal(toView: view)
        headerView.top(toView: view)
        
        tableView.horizontal(toView: view)
        tableView.verticalSpacing(toView: headerView)
        tableView.bottom(toView: view)
        
        fetchData()
        
    }
    override func fetchData() {
        ui.avatarImgView.downloadImage(from: "https://realitybuzz.files.wordpress.com/2010/01/steve_harvey.jpeg")
        ui.nameTextField.text = "Steve Harley"
        ui.emailTextField.text = "steve.harley@gmail.com"
        ui.mealCountTextField.text = "5"
        ui.calorieLimitTextField.text = "270"
        
    }
    
    override func didSelectRow(at indexPath: IndexPath) {
        let ctr = CTMealDetailCtr()
        ctr.data = datasource[indexPath.row]
        push(ctr)
    }
    
}
