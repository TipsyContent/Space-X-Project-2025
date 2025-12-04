import SwiftUI

struct ContentView: View {
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
