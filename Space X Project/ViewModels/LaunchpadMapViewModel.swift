//
//  LaunchpadMapViewModel.swift
//  Space X Project
//
//  Created by Tipsy on 02/12/2025.
//

import Foundation

/// ViewModel for managing landing pad map data
@MainActor
final class LandingPadMapViewModel2: ObservableObject {
    @Published var landingPads: [LandingPad] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    /// Fetches all landing pads from the LandingPadService
    func fetchLandingPads() {
        isLoading = true
        errorMessage = nil
        
        LandingPadService.shared.fetchAllLandingPads { [weak self] result in
            switch result {
            case .success(let landingPads):
                self?.landingPads = landingPads
                self?.isLoading = false
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
                self?.isLoading = false
            }
        }
    }
}
