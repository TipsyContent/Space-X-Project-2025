//
//  Space_X_ProjectApp.swift
//  Space X Project
//
//  Created by Tipsy on 02/12/2025.
//

import SwiftUI
// import Firebase if needed

@main
struct Space_X_ProjectApp: App {
    
    // Shared ViewModels
    @StateObject var launchListVM = LaunchListViewModel()
    
    init() {
        // Firebase setup if used
        // FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            LaunchListView()
                .preferredColorScheme(.dark)
                .environmentObject(launchListVM)
                .onAppear {
                    // Use placeholder launches for instant preview
                    if launchListVM.launches.isEmpty {
                        launchListVM.launches = PreviewData.launches
                    }
                    // Uncomment to fetch real API data
                    launchListVM.fetchLaunches()
                }
        }
    }
}
