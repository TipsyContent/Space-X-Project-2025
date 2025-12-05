import SwiftUI

// Main container view displaying the app's three main tabs
// Uses @EnvironmentObject to access AuthStateManager across all child views
// AuthStateManager is from App level and shared throughout view
struct ContentView: View {
    // @EnvironmentObject: Accesses object passed down from parent
    @EnvironmentObject var authStateManager: AuthStateManager
    
    var body: some View {
        TabView {
            LaunchesTabView()
                .tabItem {
                    Label("Launches", systemImage: "paperplane.fill")
                }
            
            LaunchPadMapView()
                .tabItem {
                    Label("Launch Pads", systemImage: "map.fill")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthStateManager())
        .preferredColorScheme(.dark)
}
