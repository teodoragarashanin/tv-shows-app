//
//  AppDelegate.swift
//  TvShowsApp
//
//  Created by MacBook on 01/06/2020.
//  Copyright © 2020 Teodora Garasanin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var isUserRemembered = false
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        checkIfUserExists()
        return true
    }
    
    func checkIfUserExists() {
        isUserRemembered = UserDefaults.standard.bool(forKey: Constants.REMEMBERED)
        if isUserRemembered {
            let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "ShowsVC")
            window?.rootViewController = vc
            window?.makeKeyAndVisible()
        } else {
            let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "LoginNavigationVC")
            window?.rootViewController = vc
            window?.makeKeyAndVisible()
        }
    }
    
}
