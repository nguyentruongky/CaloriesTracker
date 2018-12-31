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
        let dateView = knDateView()
        let timeView = knTimePicker()
        let caloriesSlider: UISlider = {
            let view = UISlider()
            view.translatesAutoresizingMaskIntoConstraints = false
            let currentValue = Float(appSetting.standardCalories / 2)
            view.minimumValue = 100
            view.maximumValue = currentValue * 2
            view.value = currentValue
            
            return view
        }()
        lazy var caloriesAmountLabel = UIMaker.makeLabel(text: String(Int(caloriesSlider.value)),
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
            return selectedTime.time
        }
        
        func setupView() -> [knTableCell] {
            return [makeTimeCell(), makeCaloriesCell(), makeNoteCell(), makeButtonCell()]
        }
        
        private func makeTimeCell() -> knTableCell {
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
            
            var dates = getDates()
            dates[0].selected = true
            dateView.selectedIndex = IndexPath.zero
            dateView.datasource = dates
            
            var times = CTTimeGetter().getTodaySlots().map({ return knTime(time: $0) })
            times[0].selected = true
            timeView.selectedIndex = IndexPath.zero
            timeView.datasource = times
            
            dateView.selectAction = { [weak self] in
                guard let `self` = self else { return }
                var times = self.getTimeSlots().map({ return knTime(time: $0) })
                times[0].selected = true
                self.timeView.selectedIndex = IndexPath.zero
                self.timeView.datasource = times
            }
            
            return cell
        }
        
        private func makeCaloriesCell() -> knTableCell {
            caloriesSlider.addTarget(self, action: #selector(updateCaloriesValue), for: .valueChanged)
            
            let title = "How many calories would you like to eat?"
            let titleLabel = UIMaker.makeLabel(text: title, font: UIFont.main(.bold, size: 17),
                                               color: .CT_25, numberOfLines: 2)
            let view = UIMaker.makeView()
            view.addSubviews(views: titleLabel, caloriesAmountLabel, caloriesSlider)
            view.addConstraints(withFormat: "V:|-16-[v0]-24-[v1]-24-[v2]-32-|", views: titleLabel, caloriesAmountLabel, caloriesSlider)
            titleLabel.horizontal(toView: view, space: padding)
            caloriesAmountLabel.centerX(toView: view)
            caloriesSlider.horizontal(toView: titleLabel)
            
            let cell = knTableCell()
            cell.backgroundColor = .white
            
            cell.addSubviews(views: view)
            view.fill(toView: cell)
            
            return cell
        }
        
        private func makeNoteCell() -> knTableCell {
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
        
        private func makeButtonCell() -> knTableCell {
            let cell = knTableCell()
            cell.addSubviews(views: saveButton)
            saveButton.fill(toView: cell, space: UIEdgeInsets(left: padding, bottom: 32, right: padding))
            return cell
        }
        
        @objc func updateCaloriesValue() {
            caloriesAmountLabel.text = String(Int(caloriesSlider.value))
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
    
    func getTimeSlots() -> [String] {
        let timeGetter = CTTimeGetter()
        if dateView.selectedIndex?.row == 0 {
            return timeGetter.getTodaySlots()
        } else {
            return timeGetter.getSlots(startHour: 0, startMinute: 0)
        }
    }
    
    
}
