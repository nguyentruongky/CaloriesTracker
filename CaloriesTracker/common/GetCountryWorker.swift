//
//  GetCountryWorker.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/29/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import Foundation

struct Country {
    var city: String?
    var countryCode: String?
    var lat: Double = 0
    var long: Double = 0
    var ip: String?
    var region: String?
    var regionName: String?
    var timeZone: String?
    var zip: String?
    
    init(raw: AnyObject) {
        city = raw["city"] as? String
        countryCode = raw["countryCode"] as? String
        lat = raw["lat"] as? Double ?? 0
        long = raw["lon"] as? Double ?? 0
        ip = raw["query"] as? String
        region = raw["region"] as? String
        regionName = raw["regionName"] as? String
        timeZone = raw["timezone"] as? String
        zip = raw["zip"] as? String
    }
}

struct knGetCountryWorker {
    private let api = "http://ip-api.com/json"
    private var successAction: ((Country) -> Void)?
    private var failAction: ((knError) -> Void)?
    init(successAction: ((Country) -> Void)?, failAction: ((knError) -> Void)?) {
        self.successAction = successAction
        self.failAction = failAction
    }
    
    func execute() {
        ServiceConnector.get(api, success: successResponse, fail: failResponse)
    }
    
    func successResponse(returnData: AnyObject) {
        let country = Country(raw: returnData)
        successAction?(country)
    }
    
    func failResponse(err: knError) {
        print("Get country fail", err)
    }
}
