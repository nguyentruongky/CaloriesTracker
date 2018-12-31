//
//  TimeGetter.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 1/1/19.
//  Copyright © 2019 Ky Nguyen. All rights reserved.
//

import Foundation
struct CTTimeGetter {
    func getSlots(startHour: Int, startMinute: Int) -> [String] {
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
    
    func getTodaySlots() -> [String] {
        let now = Date()
        return getSlots(startHour: now.hour, startMinute: now.minute)
    }
    
    func formatSlots(hour: Int, minute: Int) -> String {
        return String(format: "%02d:%02d", hour, minute)
    }
    
    func getInterval(date: String, time: String) -> Double {
        var string = date + " - " + time
        var format = "dd MMM yyyy - hh:mm"
        if time.starts(with: "12") {
            format = "dd MMM yyyy - hh:mm a"
            string = date + " - " + time + " pm"
        }
        let realDate = Date(dateString: string, format: format)
        return realDate.timeIntervalSince1970
    }
}
