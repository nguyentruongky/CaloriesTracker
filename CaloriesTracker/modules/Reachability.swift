//
//  Reachability.swift
//  Coinhako
//
//  Created by Ky Nguyen on 10/18/17.
//  Copyright © 2017 Coinhako. All rights reserved.
//

import SystemConfiguration

class knCheckConnectionWorker: NSObject {
    
    let repeatSeconds: Double = 5
    private var allowShowMessage = true
    private var isMessageOnScreen = false
    func execute() {
        repeatChecking()
    }
    
    func repeatChecking() {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        run(execute, after: repeatSeconds)
    }
    
    func show() {
        allowShowMessage = true
        execute()
    }
    
    func hide() {}
    func closeMessage() {}
}



public class Reachability {
    
    static var isConnected: Bool {
        return isConnectedToNetwork()
    }
    
    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        /* Only Working for WIFI
         let isReachable = flags == .reachable
         let needsConnection = flags == .connectionRequired
         
         return isReachable && !needsConnection
         */
        
        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        
        return ret
        
    }
}
