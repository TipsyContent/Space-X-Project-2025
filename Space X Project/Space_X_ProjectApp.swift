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
    
    // Connects the AppDelegate to handle Firebase setup and other app-level tasks
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    // Auth state manager to track if the user is logged in
    @StateObject var authStateManager = AuthStateManager()
    
    var body: some Scene {
        WindowGroup {
            // Conditional navigation based on authentication state
            if authStateManager.isLoggedIn {
                ContentView()
                    .environmentObject(authStateManager)
            } else {
                // Show authentication screen if not logged in
                NavigationStack {
                    AuthView()
                        .environmentObject(authStateManager)
                }
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    // Called when the app finishes launching
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // Initialize Firebase
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
