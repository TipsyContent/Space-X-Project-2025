import SwiftUI

// MARK: - LaunchesTabView
// Tab view med toggle mellem alle launches og gemte launches
// Bruger LaunchListViewModel for alle launches
// Bruger SavedLaunchesViewModel for gemte launches
struct LaunchesTabView: View {
    @StateObject var launchListVM = LaunchListViewModel()
    @State private var showSavedOnly = false
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                // MARK: - Picker for All/Saved toggle
                Picker("View", selection: $showSavedOnly) {
                    Text("All Launches").tag(false)
                    Text("Saved Launches").tag(true)
                }
                .pickerStyle(.segmented)
                .padding()
                
                // MARK: - Conditional views
                if showSavedOnly {
                    SavedLaunchesListView(navigationPath: $navigationPath)
                } else {
                    LaunchListView(
                        viewModel: launchListVM,
                        navigationPath: $navigationPath
                    )
                    .task {
                        if launchListVM.launches.isEmpty {
                            await launchListVM.fetchLaunches()
                        }
                    }
                }
            }
            .navigationTitle("SpaceX Launches")
            .navigationBarTitleDisplayMode(.large)
            .navigationDestination(for: Launch.self) { launch in
                LaunchDetailView(launch: launch)
            }
            .background(Color(hex: "023E61").edgesIgnoringSafeArea(.all))
        }
    }
}

#Preview {
    let vm = LaunchListViewModel()
    vm.launches = PreviewData.launches
    
    return NavigationStack {
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
        .navigationTitle("SpaceX Launches")
        .navigationBarTitleDisplayMode(.large)
        .background(Color(hex: "023E61").edgesIgnoringSafeArea(.all))
    }
    .preferredColorScheme(.dark)
}
