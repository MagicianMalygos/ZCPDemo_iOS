//
//  AppDelegate.swift
//  SwiftDemo
//
//  Created by 朱超鹏 on 17/3/9.
//  Copyright © 2017年 zcp. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow()
        let listVC = ListViewController()
        listVC.view.frame = UIScreen.main.bounds
        let nav = UINavigationController(rootViewController: listVC)
        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()
        
        
        let v = ViewController()
        v.viewDidLoad()
        
        return true
    }
}

