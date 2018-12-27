//
//  AppDelegate.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/20/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupApp()
        setupNavigationBar()
        FirebaseApp.configure()
        
        getMyProfile()
        return true
    }
    
    func setupApp() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = StartPoint.startingController
        window!.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
    }
    
    func setupNavigationBar() {
        let bar = UINavigationBar.appearance()
        bar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.CT_25,
            NSAttributedString.Key.font: UIFont.main(.bold, size: 17),
        ]
        
        bar.barTintColor = UIColor.white
        bar.tintColor = UIColor.CT_25
        bar.setBackgroundImage(UIImage.createImage(from: .white), for: .default)
    }
    
    func getMyProfile() {
        func didGet(_ user: CTUser) {
            appSetting.user = user
        }
        
        guard let id = appSetting.userId else { return }
        CTGetProfileWorker(userId: id, successAction: didGet, failAction: nil).execute()
    }
    
    @objc func hideKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil, from: nil, for: nil)
    }
}

