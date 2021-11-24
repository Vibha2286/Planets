//
//  PlanetsApp.swift
//  Planets
//
//  Created by Vibha Mangrulkar on 2021/11/19.
//

import SwiftUI

@available(iOS 14.0, *)
struct Planets: App {
    
    /// Root screen to display
    var body: some Scene {
        WindowGroup {
            PlanetListView().environment(\.locale, .init(identifier: "en"))

        }
    }
}

@main
struct PlanetProjectAppWrapper {
    static func main() {
        if #available(iOS 14.0, *) {
            Planets.main()
        }
        else {
            UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, NSStringFromClass(AppDelegate.self))
        }
    }
}
