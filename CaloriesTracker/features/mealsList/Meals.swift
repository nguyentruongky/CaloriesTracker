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
    static var needRecheckCalories = false
    static var shouldUpdateUpcoming = false
    
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
        statusBarStyle = .lightContent
        
        if CTMealsDashboard.shouldUpdateUpcoming {
            updateUpcomingMeals()
            CTMealsDashboard.shouldUpdateUpcoming = false
        }
        
        if CTMealsDashboard.needRecheckCalories {
            recheckCalories()
            CTMealsDashboard.needRecheckCalories = false
        }
    }
    
    func updateUpcomingMeals() {
        didLoadUpcomingMeals = false
        output.getUpcomingMeals()
    }
    
    func recheckCalories() {
        var meals = datasource
        meals.append(contentsOf: upcomingMeals)
        CaloriesChecker().checkCaloriesStandard(for: meals,
                                                standard: appSetting.standardCalories)
        ui.upcomingMealsView.collectionView.reloadData()
        tableView.reloadData()
    }
    
    override func setupView() {
        super.setupView()
        navBarHidden = .hidden
        tableView.backgroundColor = UIColor.bg
        view.addFill(tableView)
        tableView.setHeader(ui.greetingView, height: 170)
        
        view.addSubviews(views: ui.filterButton)
        ui.filterButton.centerX(toView: view)
        ui.filterButton.bottom(toAnchor: view.safeAreaLayoutGuide.bottomAnchor, space: -padding)
        
        view.addFill(ui.stateWrapper)
        
        (ui.greetingView.viewWithTag(1001) as? UIButton)?.addTarget(self, action: #selector(showAddMeal))
        (ui.stateWrapper.viewWithTag(1001) as? UIButton)?.addTarget(self, action: #selector(showAddMeal))
        ui.filterButton.addTarget(self, action: #selector(showFilter))
        
        fetchData()
    }
    
    @objc func showFilter() {
        present(wrap(CTFilterCtr()))
    }
    
    @objc func showAddMeal() {
        let ctr = CTAddMealCtr()
        ctr.hidesBottomBarWhenPushed = true
        push(ctr)
    }
    
    override func fetchData() {
        output.getPreviousMeals()
        output.getUpcomingMeals()
    }
    
    override func didSelectRow(at indexPath: IndexPath) {
        if indexPath.row == 0 { return }
        let ctr = CTMealDetailCtr()
        ctr.data = datasource[indexPath.row - 1]
        push(ctr)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        statusBarHidden = scrollView.contentOffset.y > 0
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
        return 265
    }
}
