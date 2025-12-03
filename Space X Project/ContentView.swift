import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            LaunchesTabView()
                .tabItem {
                    Label("Launches", systemImage: "rocket.fill")
                }
            
            LandingPadMapView()
                .tabItem {
                    Label("Landing Pads", systemImage: "map.fill")
                }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    let vm = LaunchListViewModel()
    vm.launches = PreviewData.launches

    return TabView {
        VStack {
            Picker("View", selection: .constant(false)) {
                Text("All Launches").tag(false)
                Text("Saved Launches").tag(true)
            }
            .pickerStyle(.segmented)
            .padding()

            LaunchListView(
                viewModel: vm,
                navigationPath: .constant(NavigationPath())
            )
        }
        .tabItem {
            Label("Launches", systemImage: "rocket.fill")
        }

        VStack(spacing: 20) {
            Image(systemName: "map.fill")
                .font(.system(size: 50))
                .foregroundColor(.blue)
            Text("Landing Pads Map")
                .font(.headline)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: "023E61"))
        .tabItem {
            Label("Landing Pads", systemImage: "map.fill")
        }
    }
    .preferredColorScheme(.dark)
}
