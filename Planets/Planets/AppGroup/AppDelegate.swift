//
//  AppDelegate.swift
//  Planets
//
//  Created by Vibha Mangrulkar on 2021/11/19.
//

import SwiftUI

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(
        _: UIApplication,
        didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        window.rootViewController = UIHostingController(
            rootView: PlanetListView()
        )
        self.window = window
        window.makeKeyAndVisible()
        return true
    }
}
