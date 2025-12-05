//
//  LandingPadMapViewModel.swift
//  Space X Project
//
//  Created by Tipsy on 03/12/2025.
//


import Foundation
// ViewModel for managing landing pad data with the idea to also showcase landing pads on map
// fetches all landing pads and manges loading error state
// @MainActor ensures all methods/properties are main-thread safe
@MainActor
final class LandingPadMapViewModel: ObservableObject {
    @Published var landingPads: [LandingPad] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    // Async fetch method
    func fetchLandingPads() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let pads = try await LandingPadService.shared.fetchAllLandingPads()
            landingPads = pads
            isLoading = false
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
        }
    }
}
