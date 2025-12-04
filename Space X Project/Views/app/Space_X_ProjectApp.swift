//
//  Space_X_ProjectApp.swift
//  Space X Project
//
//  Created by Tipsy on 02/12/2025.
//

import SwiftUI
import Firebase

@main
struct Space_X_ProjectApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var authStateManager = AuthStateManager()
    
    var body: some Scene {
        WindowGroup {
            if authStateManager.isLoggedIn {
                ContentView()
                    .environmentObject(authStateManager)
            } else {
                NavigationStack {
                    AuthView()
                        .environmentObject(authStateManager)
                }
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        print("Firebase Running")
        return true
    }
}
