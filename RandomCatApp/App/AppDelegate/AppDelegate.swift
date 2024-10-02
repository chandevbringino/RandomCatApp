//
//  AppDelegate.swift
//  RandomCatApp
//
//  Created by Christian Bringino on 10/1/24.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        App.shared.bootstrap(with: application, launchOptions: launchOptions)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let vc = R.storyboard.splashScreen.splashScreenController()!
        
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        return true
    }
}

