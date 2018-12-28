//
//  MealList.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/29/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit

class CTMealList: knListController<CTMealCell, CTMeal> {
    override var datasource: [CTMeal] { didSet {
        addState()
        stateView?.setStateContent(state: .empty, imageName: "no_meal", title: "No record found", content: "")
        
        stateView?.state = datasource.isEmpty ? .empty : .success
        tableView.reloadData()
    }}
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hideBar(false)
    }
    
    override func setupView() {
        statusBarStyle = .default
        rowHeight = 265
        tableView.backgroundColor = .bg
        addBackButton(tintColor: .CT_25)
        title = "FILTER RESULT"
        contentInset = UIEdgeInsets(top: padding)
        super.setupView()
        view.addFill(tableView)
    }
    
    override func didSelectRow(at indexPath: IndexPath) {
        let ctr = CTMealDetailCtr()
        ctr.data = datasource[indexPath.row]
        push(ctr)
    }
}

