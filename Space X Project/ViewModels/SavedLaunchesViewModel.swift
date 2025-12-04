import Foundation

// MARK: - SavedLaunchesViewModel
// Loader gemte launches fra Firebase Firestore
@MainActor
final class SavedLaunchesViewModel: ObservableObject {
    @Published var launches: [Launch] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    // MARK: - Load saved launches
    func loadSavedLaunches() async {
        isLoading = true
        errorMessage = nil
        launches = []
        
        let savedIDs = await LaunchStorage.shared.getSavedLaunchIDs()
        
        guard !savedIDs.isEmpty else {
            isLoading = false
            return
        }
        
        do {
            var loadedLaunches: [Launch] = []
            
            loadedLaunches = try await withThrowingTaskGroup(of: Launch?.self) { group in
                for id in savedIDs {
                    group.addTask {
                        try? await LaunchService.shared.fetchLaunch(id: id)
                    }
                }
                
                var results: [Launch] = []
                for try await launch in group {
                    if let launch = launch {
                        results.append(launch)
                    }
                }
                return results
            }
            
            self.launches = loadedLaunches.sorted { $0.date_utc > $1.date_utc }
            isLoading = false
            
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
        }
    }
}
