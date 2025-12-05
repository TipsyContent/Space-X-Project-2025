//
//  LaunchListViewModel 2.swift
//  Space X Project
//
//  Created by Tipsy on 02/12/2025.
//


import Foundation
// Viewmodel for managing launch list view state and dats
// fetches all launches from api and manages loading error state
// @MainActor ensures all methods/properties are main-thread safe
@MainActor
final class LaunchListViewModel: ObservableObject {
    @Published var launches: [Launch] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func fetchLaunches() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let launches = try await LaunchService.shared.fetchAllLaunches()
            self.launches = launches.sorted { $0.date_utc > $1.date_utc }
            isLoading = false
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
        }
    }
}

