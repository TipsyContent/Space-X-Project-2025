import SwiftUI

// Displays a list of SpaceX launches using a list view.
// Handles loading, error states, and navigation to launch details.
struct LaunchListView: View {
    @ObservedObject var viewModel: LaunchListViewModel
    @Binding var navigationPath: NavigationPath
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            ZStack {
                Color(hex: "023E61").edgesIgnoringSafeArea(.all)
                
                // Loading indicator shown only when list is empty
                if viewModel.isLoading && viewModel.launches.isEmpty {
                    ProgressView()
                        .tint(.blue)
                } else if let error = viewModel.errorMessage {
                    ErrorView(error: error)
                    // Fallback if no launches exist
                } else if viewModel.launches.isEmpty {
                    Text("No launches available")
                        .foregroundColor(.white)
                    
                    // Main launch list
                } else {
                    List {
                        ForEach(viewModel.launches) { launch in
                            NavigationLink(value: launch) {
                                LaunchRow(launch: launch)
                            }
                            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                            .listRowSeparator(.visible)
                            .listRowBackground(Color(hex: "045788"))
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .listStyle(.plain)
                }
            }
            .navigationTitle("SpaceX Launches")
            .navigationDestination(for: Launch.self) { launch in
                LaunchDetailView(launch: launch)
            }
            .task {
                await viewModel.fetchLaunches()
            }
        }
    }
}

// Reusable view displaying error information
struct ErrorView: View {
    let error: String
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 40))
                .foregroundColor(.red)
            Text("Error loading launches")
                .font(.headline)
                .foregroundColor(.white)
            Text(error)
                .font(.caption)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

#Preview {
    let vm = LaunchListViewModel()
    vm.launches = PreviewData.launches
    
    return NavigationStack {
        LaunchListView(
            viewModel: vm,
            navigationPath: .constant(NavigationPath())
        )
    }
    .preferredColorScheme(.dark)
}
