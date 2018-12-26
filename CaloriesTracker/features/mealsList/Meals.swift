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
    var didLoadUpcomingMeals = false
    var didLoadPreviousMeals = false
    
    override var datasource: [CTMeal] { didSet {
        ui.setPreviousMealLabel(visible: !datasource.isEmpty)
    }}
    var upcomingMeals = [CTMeal]() { didSet {
        ui.setUpcomingView(visible: !upcomingMeals.isEmpty)
        ui.upcomingMealsView.datasource = upcomingMeals
    }}
    
    lazy var output = Interactor(controller: self)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hideBar(true)
        fetchData()
    }
    
    override func setupView() {
        super.setupView()
        tableView.backgroundColor = UIColor.bg
        view.addFill(tableView)
        tableView.setHeader(ui.greetingView, height: 170)
        
        view.addFill(ui.stateWrapper)
        
        (ui.greetingView.viewWithTag(1001) as? UIButton)?.addTarget(self, action: #selector(showAddMeal))
    }
    
    @objc func showAddMeal() {
        let ctr = CTAddMealCtr()
        ctr.hidesBottomBarWhenPushed = true
        push(ctr)
    }
    
    override func fetchData() {
        ui.stateView.state = .loading
        output.getPreviousMeals()
        output.getUpcomingMeals()
    }
    
    override func didSelectRow(at indexPath: IndexPath) {
        let ctr = CTMealDetailCtr()
        ctr.data = datasource[indexPath.row - 1]
        push(ctr)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        isStatusBarHidden = scrollView.contentOffset.y > 0
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count + 1
    }
    
    override func getCell(at index: IndexPath) -> UITableViewCell {
        if index.row == 0 { return ui.upcomingCell }
        let cell = tableView.dequeueReusableCell(withIdentifier: "CTMealCell", for: index) as! CTMealCell
        cell.data = datasource[index.row - 1]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 { return UITableView.automaticDimension }
        return 244
    }
}
