//
//  SavedLaunchesViewModel.swift
//  Space X Project
//
//  Created by Tipsy on 02/12/2025.
//
import Foundation

@MainActor
final class SavedLaunchesViewModel: ObservableObject {
    @Published var launches: [Launch] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    // Async load saved launches
    func loadSavedLaunches() async {
        isLoading = true
        errorMessage = nil
        launches = []
        
        let savedIDs = LaunchStorage.shared.getSavedLaunchIDs()
        guard !savedIDs.isEmpty else {
            isLoading = false
            return
        }
        
        do {
            var loadedLaunches: [Launch] = []
            
            // Fetch all launches in parallel
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
            
            // Sort by date descending
            launches = loadedLaunches.sorted { $0.date_utc > $1.date_utc }
            isLoading = false
            
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
        }
    }
}
