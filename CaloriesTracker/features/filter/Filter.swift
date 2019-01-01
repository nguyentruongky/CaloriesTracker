//
//  Filter.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/27/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit
class CTFilterOptions {
    var fromDate: Date?
    var toDate: Date?
    var regimens = [String]()
}

class CTFilterCtr: knStaticListController {
    enum DateTypeFilter {
        case from, to
    }
    
    private let ui = UI()
    private var options = CTFilterOptions()
    private var dateFilter = DateTypeFilter.from
    
    override func setupView() {
        title = "FILTER"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "close"), style: .done, target: self, action: #selector(dismissBack))
        contentInset = UIEdgeInsets(top: padding)
        super.setupView()
        datasource = ui.setupView()
        view.addFill(tableView)
        
        ui.datePicker.delegate = self
        ui.fromButton.addTarget(self, action: #selector(showFromDate))
        ui.toButton.addTarget(self, action: #selector(showToDate))
        ui.applyButton.addTarget(self, action: #selector(applyFilter))
        
        fetchData()
    }
    
    @objc func showFromDate() {
        ui.datePicker.show(in: self)
        dateFilter = .from
    }
    
    @objc func showToDate() {
        ui.datePicker.show(in: self)
        dateFilter = .to
    }
    
    @objc func applyFilter() {
        ui.applyButton.setProcess(visible: true)
        saveRegimenOptions()
        CTFilterWorker(options: options, successAction: didFilter, failAction: nil).execute()
    }
    
    private func saveRegimenOptions() {
        let selectedRegimens = ui.regimenView.datasource.filter({ return $0.selected == true })
        options.regimens = selectedRegimens.map({ return $0.text })
    }
    
    private func didFilter(_ meals: [CTMeal]) {
        ui.applyButton.setProcess(visible: false)
        let ctr = CTMealList()
        ctr.datasource = meals
        push(ctr)
    }
    
    override func fetchData() {
        ui.regimenView.datasource = [
            CTRegimen(text: "Breakfast"),
            CTRegimen(text: "Lunch"),
            CTRegimen(text: "Collation"),
            CTRegimen(text: "Dinner")
        ]
    }
}

extension CTFilterCtr: knPickerViewDelegate {
    func didSelectDate(_ date: Date) {
        if dateFilter == .from {
            options.fromDate = date
            ui.fromButton.setTitle(date.toString("dd MMM yyyy - hh:mm"))
            ui.fromButton.setTitleColor(.CT_25)
        } else {
            options.toDate = date
            ui.toButton.setTitle(date.toString("dd MMM yyyy - hh:mm"))
            ui.toButton.setTitleColor(.CT_25)
        }
    }
}
