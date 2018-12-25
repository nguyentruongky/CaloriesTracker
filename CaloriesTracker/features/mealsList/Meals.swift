//
//  Meals.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/21/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit

class CTMealsDashboard: knListController<CTMealCell, CTMeal> {
    let ui = UI()
    lazy var output = Interactor(controller: self)
    let headerHeight: CGFloat = 695
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hideBar(true)
    }
    
    override func setupView() {
        rowHeight = 275
        super.setupView()
        tableView.backgroundColor = UIColor.bg
        tableView.setHeader(ui.makeStateHeaderView(), height: screenHeight)
        view.addFill(tableView)
        
        ui.addButton.addTarget(self, action: #selector(showAddMeal))
        fetchData()
    }
    
    @objc func showAddMeal() {
        let ctr = CTAddMealCtr()
        ctr.hidesBottomBarWhenPushed = true
        push(ctr)
    }
    
    func showEmpty() {
        tableView.setHeader(ui.makeStateHeaderView(), height: screenHeight)
        tableView.isScrollEnabled = false
    }
    
    override func fetchData() {
        ui.emptyView.state = .loading
        output.getPreviousMeals()
        output.getUpcomingMeals()
    }
    
    override func didSelectRow(at indexPath: IndexPath) {
        let ctr = CTMealDetailCtr()
        ctr.data = datasource[indexPath.row]
        push(ctr)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        isStatusBarHidden = scrollView.contentOffset.y > 0
        setNeedsStatusBarAppearanceUpdate()
    }
}


