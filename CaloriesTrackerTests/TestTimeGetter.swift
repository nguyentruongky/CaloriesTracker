//
//  CaloriesTrackerTests.swift
//  CaloriesTrackerTests
//
//  Created by Ky Nguyen Coinhako on 1/1/19.
//  Copyright © 2019 Ky Nguyen. All rights reserved.
//

import XCTest
import Firebase
@testable import CaloriesTracker

class TimeGetterTests: XCTestCase {
    func testGetDaySlots() {
        let getter = CTTimeGetter()
        let slots = getter.getSlots(startHour: 0, startMinute: 0)
        XCTAssertTrue(slots.count == 24 * 4, "A day have 96 slots")
        XCTAssertTrue(slots.first == "00:00")
        XCTAssertTrue(slots.last == "23:45")
    }
    
    func testGetSlotsFromHour() {
        let getter = CTTimeGetter()
        let slots = getter.getSlots(startHour: 12, startMinute: 0)
        XCTAssertTrue(slots.count == 12 * 4, "A day have 48 slots")
        XCTAssertTrue(slots.first == "12:00")
        XCTAssertTrue(slots.last == "23:45")
    }
    
    func testGetTimeInterval() {
        let getter = CTTimeGetter()
        let interval = getter.getInterval(date: "31 Dec 2018", time: "09:00")
        XCTAssertTrue(interval < Date().timeIntervalSince1970)
        
        let date = Date(dateString: "31/12/2018 - 09:00", format: "dd/MM/yyyy - hh:mm")
        XCTAssertTrue(date.timeIntervalSince1970 == interval)
    }
    
    func testGetTimeIntervalNoon() {
        let getter = CTTimeGetter()
        let interval = getter.getInterval(date: "31 Dec 2018", time: "12:15")
        XCTAssertTrue(interval < Date().timeIntervalSince1970)
        
        let date = Date(dateString: "31/12/2018 - 15:00", format: "dd/MM/yyyy - hh:mm")
        XCTAssertTrue(date.timeIntervalSince1970 > interval)
    }
}
