//
//  TimeView.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/22/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit
class CTMealTimeView: knView {
    let dateView = knDateView()
    let timeView = knTimePicker()
    let saveButton = UIMaker.makeMainButton(title: "Save and next")
    
    override func setupView() {
        let title = "What time do you want to eat?"
        let titleLabel = UIMaker.makeLabel(text: title, font: UIFont.main(.bold, size: 17),
                                           color: .CT_25, numberOfLines: 2, alignment: .center)
        addTopLineDateView()
        let view = UIMaker.makeView()
        view.addSubviews(views: titleLabel, dateView, timeView, saveButton)
        view.addConstraints(withFormat: "V:|-32-[v0]-32-[v1]-24-[v2]-32-[v3]-32-|", views: titleLabel, dateView, timeView, saveButton)
        titleLabel.horizontal(toView: view, space: padding)
        dateView.horizontal(toView: view)
        dateView.height(82)
        
        timeView.horizontal(toView: dateView)
        timeView.height(40)
        
        saveButton.horizontal(toView: view, space: padding)
        
        addSubviews(views: view)
        view.horizontal(toView: self)
        view.top(toView: self, space: 0)
        
        dateView.datasource = getDates()
        timeView.datasource = getTimeSlots()
    }
    
    func addTopLineDateView() {
        let line = UIMaker.makeHorizontalLine(color: UIColor.CT_222, height: 1)
        dateView.addSubviews(views: line)
        line.horizontal(toView: dateView)
        line.top(toView: dateView)
    }
    
    func getDates() -> [knDate] {
        var dates = [knDate]()
        let today = Date()
        for i in 0 ..< 7 {
            dates.append(knDate(date: today.addingTimeInterval(Double(i*24*60*60))))
        }
        return dates
    }
    
    func getTimeSlots() -> [String] {
        return ["10:00", "11:00", "12:00"]
//        var slots = [String]()
//        if dateView.selectedIndex?.row == 0 {
//            let now = Date()
//            var minute = now.minute
//
//            for hour in now.hour ..< 24 {
//
//            }
//
//        }
//        return slots
    }
}
