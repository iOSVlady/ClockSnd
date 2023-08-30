//
//  ClockSndApp.swift
//  ClockSnd
//
//  Created by Vlady on 26.08.2023.
//

import SwiftUI
import UIKit
import Firebase
import FirebaseAppCheck

@main
struct ClockSndApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        // Setup App Check Debug Token Provider.
#if targetEnvironment(simulator)
        if #available(iOS 14.0, *) {
            AppCheck.setAppCheckProviderFactory(AppCheckDebugProviderFactory())
        } else {
            // Fallback on earlier versions
            NSLog("Debug App Check Provider is not supported on iOS version less than 14.0.")
        }
#endif
        
        return true
  }
}


