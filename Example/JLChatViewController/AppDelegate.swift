//
//  AppDelegate.swift
//  JLChatViewController
//
//  Created by José Lucas on 12/07/2015.
//  Copyright (c) 2015 José Lucas. All rights reserved.
//

import UIKit
import JLChatViewController

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]?) -> Bool {
        // Override point for customization after application launch.
        
        JLBundleController.loadJLChatStoryboard()
        
        return true
    }



}

