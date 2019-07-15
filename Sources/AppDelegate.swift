//
//  AppDelegate.swift
//  PRSlideViewExample
//
//  Created by Elethom Hunter on 7/15/19.
//  Copyright © 2019 Wiredcraft. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    lazy var window: UIWindow? = {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.backgroundColor = UIColor.white
        window.makeKeyAndVisible()
        return window
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window?.rootViewController = ViewController()
        return true
    }
    
}
