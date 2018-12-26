//
//  MealOptionView.UI.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/25/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit

extension CTMealOptionView {
    class UI: NSObject {
        private let dateView = knDateView()
        private let timeView = knTimePicker()
        let caloriesSlider: UISlider = {
            let view = UISlider()
            view.translatesAutoresizingMaskIntoConstraints = false
            let currentValue = Float(appSetting.standardCalories)
            view.minimumValue = currentValue / 2
            view.maximumValue = currentValue * 1.5
            view.value = currentValue
            
            return view
        }()
        let amountLabel = UIMaker.makeLabel(text: String(appSetting.standardCalories),
                                            font: UIFont.main(.bold, size: 45),
                                            color: .CT_25)
        let noteTextView = UIMaker.makeTextView(placeholder: "Your note goes here",
                                                font: UIFont.main(),
                                                color: UIColor.CT_25)
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
        
        func setupView() -> [knTableCell] {
            return [makeTimeCell(), makeCaloriesCell(), makeNoteCell(), makeButtonCell()]
        }
        
        func makeTimeCell() -> knTableCell {
            let title = "What time do you want to eat?"
            let titleLabel = UIMaker.makeLabel(text: title, font: UIFont.main(.bold, size: 17),
                                               color: .CT_25, numberOfLines: 2)
            let line = UIMaker.makeHorizontalLine(color: UIColor.CT_222, height: 1)
            dateView.addSubviews(views: line)
            line.horizontal(toView: dateView)
            line.top(toView: dateView)

            let view = UIMaker.makeView()
            view.addSubviews(views: titleLabel, dateView, timeView)
            view.addConstraints(withFormat: "V:|-32-[v0]-32-[v1]-24-[v2]-32-|", views: titleLabel, dateView, timeView)
            titleLabel.horizontal(toView: view, space: padding)
            dateView.horizontal(toView: view)
            dateView.height(82)
            
            timeView.horizontal(toView: dateView)
            timeView.height(40)
            
            let cell = knTableCell()
            cell.backgroundColor = .white
            cell.addSubviews(views: view)
            view.fill(toView: cell)
            
            dateView.datasource = getDates()
            run({ [weak self] in
                self?.dateView.didSelectItem(at: IndexPath(row: 0, section: 0))
                }, after: 0.1)
            
            dateView.selectAction = { [weak self] in
                guard let `self` = self else { return }
                self.timeView.datasource = self.getTimeSlots()
            }
            
            return cell
        }
        
        func makeCaloriesCell() -> knTableCell {
            caloriesSlider.addTarget(self, action: #selector(updateCaloriesValue), for: .valueChanged)
            
            let title = "How many calories would you like to eat?"
            let titleLabel = UIMaker.makeLabel(text: title, font: UIFont.main(.bold, size: 17),
                                               color: .CT_25, numberOfLines: 2)
            let view = UIMaker.makeView()
            view.addSubviews(views: titleLabel, amountLabel, caloriesSlider)
            view.addConstraints(withFormat: "V:|-16-[v0]-24-[v1]-24-[v2]-32-|", views: titleLabel, amountLabel, caloriesSlider)
            titleLabel.horizontal(toView: view, space: padding)
            amountLabel.centerX(toView: view)
            caloriesSlider.horizontal(toView: titleLabel)
            
            let cell = knTableCell()
            cell.backgroundColor = .white
            
            cell.addSubviews(views: view)
            view.fill(toView: cell)
            
            return cell
        }
        
        func makeNoteCell() -> knTableCell {
            noteTextView.autocorrectionType = .no
            noteTextView.autocapitalizationType = .sentences
            
            let wrapperView = UIMaker.makeView()
            wrapperView.addSubviews(views: noteTextView)
            noteTextView.fill(toView: wrapperView, space: UIEdgeInsets(space: 4))
            wrapperView.setCorner(radius: 7)
            wrapperView.setBorder(1, color: UIColor.CT_222)
            
            let title = "Any notes?"
            let titleLabel = UIMaker.makeLabel(text: title, font: UIFont.main(.bold, size: 17),
                                               color: .CT_25, numberOfLines: 2)
            let view = UIMaker.makeView()
            view.addSubviews(views: titleLabel, wrapperView)
            view.addConstraints(withFormat: "V:|-16-[v0]-24-[v1]-32-|", views: titleLabel, wrapperView)
            titleLabel.horizontal(toView: view, space: padding)
            wrapperView.horizontal(toView: titleLabel)
            wrapperView.height(120)
            
            let cell = knTableCell()
            cell.backgroundColor = .white
            
            cell.addSubviews(views: view)
            view.fill(toView: cell)
            return cell
        }
        
        func makeButtonCell() -> knTableCell {
            let cell = knTableCell()
            cell.addSubviews(views: saveButton)
            saveButton.fill(toView: cell, space: UIEdgeInsets(left: padding, bottom: 32, right: padding))
            return cell
        }
        
        @objc func updateCaloriesValue() {
            amountLabel.text = String(Int(caloriesSlider.value))
        }
    }
}


extension CTMealOptionView.UI {
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
