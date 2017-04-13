//
//  AppDelegate.swift
//  Foodie
//
//  Created by Eduardo Pacheco on 12/04/17.
//  Copyright © 2017 Eduardo Pacheco. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setupUI()
        return true
    }

    // MARK: - Private Methods
    private func setupUI() {
        UIApplication.shared.statusBarStyle = .lightContent
        UINavigationBar.appearance().barTintColor = UIColor(red: 216/255, green: 74/255, blue: 32/255, alpha: 1.0)
        UINavigationBar.appearance().tintColor = .white
        if let barFont = UIFont(name: "AvenirNextCondensed-DemiBold", size: 24.0) {
            UINavigationBar.appearance().titleTextAttributes = [
                NSForegroundColorAttributeName: UIColor.white,
                NSFontAttributeName: barFont
            ]
        }
    }
}

