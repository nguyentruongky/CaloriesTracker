//
//  TimeView.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/22/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit
class CTMealTimeView: knView {
    private let dateView = knDateView()
    private let timeView = knTimePicker()
    let saveButton = UIMaker.makeMainButton(title: "Save and next")
    
    var date: String? {
        let index = dateView.selectedIndex?.row ?? 0
        let selectedDate = dateView.datasource[index]
        return selectedDate.date.toString("dd MMM yyyy")
    }
    
    var time: String? {
        let index = timeView.selectedIndex?.row ?? 0
        let selectedTime = timeView.datasource[index]
        return selectedTime
    }
    
    override func setupView() {
        backgroundColor = .white
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
        run({ [weak self] in
            self?.dateView.didSelectItem(at: IndexPath(row: 0, section: 0))
        }, after: 0.1)
        
        dateView.selectAction = { [weak self] in
            guard let `self` = self else { return }
            self.timeView.datasource = self.getTimeSlots()
        }
    }
    
    func addTopLineDateView() {
        let line = UIMaker.makeHorizontalLine(color: UIColor.CT_222, height: 1)
        dateView.addSubviews(views: line)
        line.horizontal(toView: dateView)
        line.top(toView: dateView)
    }
    
    private func getDates() -> [knDate] {
        var dates = [knDate]()
        let today = Date()
        for i in 0 ..< 7 {
            dates.append(knDate(date: today.addingTimeInterval(Double(i*24*60*60))))
        }
        return dates
    }
    
    private func getTimeSlots() -> [String] {
        if dateView.selectedIndex?.row == 0 {
            return getTodaySlots()
        } else {
            return getSlots(startHour: 0, startMinute: 0)
        }
    }
    
    private func getSlots(startHour: Int, startMinute: Int) -> [String] {
        var slots = [String]()
        var hour = startHour
        let minute = startMinute
        if minute != 0 {
            let quarters = [15, 30, 45, 60]
            for q in quarters where minute < q {
                if q < 60 {
                    slots.append(formatSlots(hour: hour, minute: q))
                }
            }
            hour += 1
        }
        
        let quarters = [0, 15, 30, 45]
        for h in hour ..< 24 {
            for q in quarters {
                slots.append(formatSlots(hour: h, minute: q))
            }
        }
        
        return slots
    }
    
    private func getTodaySlots() -> [String] {
        let now = Date()
        return getSlots(startHour: now.hour, startMinute: now.minute)
    }
    
    private func formatSlots(hour: Int, minute: Int) -> String {
        return String(format: "%02d:%02d", hour, minute)
    }
}
