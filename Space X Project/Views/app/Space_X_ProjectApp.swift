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
        
        // Setup image caching
        let memoryCapacity = 100 * 1024 * 1024  // 100 MB
        let diskCapacity = 500 * 1024 * 1024    // 500 MB
        let urlCache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "imageCache")
        URLCache.shared = urlCache
        
        print("Firebase Running")
        return true
    }
}
