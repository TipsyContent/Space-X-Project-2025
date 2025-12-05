import SwiftUI

// MARK: - LaunchesTabView
// Tab view allowing users to switch between all launches and saved launches.
// Uses LaunchListViewModel for all launches.
// Uses SavedLaunchesListView for saved launches.
struct LaunchesTabView: View {
    @StateObject var launchListVM = LaunchListViewModel()
    @State private var showSavedOnly = false
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                // Toggle between All Launches and Saved Launches
                Picker("View", selection: $showSavedOnly) {
                    Text("All Launches").tag(false)
                    Text("Saved Launches").tag(true)
                }
                .pickerStyle(.segmented)
                .padding()
                
                // Display either saved launches or all launches
                if showSavedOnly {
                    SavedLaunchesListView(navigationPath: $navigationPath)
                } else {
                    LaunchListView(
                        viewModel: launchListVM,
                        navigationPath: $navigationPath
                    )
                    .task {
                        // Load launches only once when the list is empty
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
