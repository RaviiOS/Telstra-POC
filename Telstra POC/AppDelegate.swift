//
//  AppDelegate.swift
//  Telstra POC
//
//  Created by Ravi Kumar Yaganti on 18/07/20.
//  Copyright © 2020 RK. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Set country DetailsViewcontroller as root.
        setupRootVC()
        return true
    }

    private func setupRootVC() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let rootVC = HomeViewController()
        let rootNC = UINavigationController(rootViewController: rootVC)
        window?.rootViewController = rootNC
        window?.makeKeyAndVisible()
    }
}

