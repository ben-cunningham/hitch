//
//  AppDelegate.swift
//  hitch
//
//  Created by Benjamin Cunningham on 2016-03-12.
//  Copyright © 2016 Benjamin Cunningham. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let controller = TableViewController()
        let navController = UINavigationController(rootViewController: controller)
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(application: UIApplication) {

    }

    func applicationDidEnterBackground(application: UIApplication) {
    
    }

    func applicationWillEnterForeground(application: UIApplication) {
        
    }

    func applicationDidBecomeActive(application: UIApplication) {
        
    }

    func applicationWillTerminate(application: UIApplication) {

    }
}

