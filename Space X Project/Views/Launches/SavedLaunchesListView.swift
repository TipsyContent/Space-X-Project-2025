import SwiftUI

struct SavedLaunchesListView: View {
    @StateObject private var viewModel = SavedLaunchesViewModel()
    @Binding var navigationPath: NavigationPath
    
    var body: some View {
        ZStack {
            Color(hex: "023E61").edgesIgnoringSafeArea(.all)
            
            if viewModel.isLoading {
                ProgressView()
                    .tint(.blue)
            } else if let error = viewModel.errorMessage {
                VStack(spacing: 12) {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.system(size: 40))
                        .foregroundColor(.red)
                    Text("Error loading saved launches")
                        .font(.headline)
                        .foregroundColor(.white)
                    Text(error)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                }
                .padding()
            } else if viewModel.launches.isEmpty {
                VStack(spacing: 12) {
                    Image(systemName: "bookmark.slash")
                        .font(.system(size: 40))
                        .foregroundColor(.gray)
                    Text("No saved launches")
                        .font(.headline)
                        .foregroundColor(.white)
                    Text("Save launches to view them here")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
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
        .navigationDestination(for: Launch.self) { launch in
            LaunchDetailView(launch: launch)
        }
        .task {
            await viewModel.loadSavedLaunches()
        }
    }
}

#Preview {
    NavigationStack {
        SavedLaunchesListView(navigationPath: .constant(NavigationPath()))
    }
    .preferredColorScheme(.dark)
}
