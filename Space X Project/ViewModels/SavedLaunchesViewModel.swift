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
    
    func loadSavedLaunches() {
        isLoading = true
        let savedIDs = LaunchStorage.shared.getSavedLaunchIDs()
        
        if savedIDs.isEmpty {
            self.launches = []
            self.isLoading = false
            return
        }
        
        var loadedLaunches: [Launch] = []
        let group = DispatchGroup()
        
        for id in savedIDs {
            group.enter()
            LaunchService.shared.fetchLaunch(id: id) { result in
                if case .success(let launch) = result {
                    loadedLaunches.append(launch)
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            self?.launches = loadedLaunches.sorted { $0.date_utc > $1.date_utc }
            self?.isLoading = false
        }
    }
}
