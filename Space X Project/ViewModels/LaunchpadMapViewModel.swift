//
//  LaunchpadMapViewModel.swift
//  Space X Project
//
//  Created by Tipsy on 02/12/2025.
//

import Foundation
// ViewModel for managing launch pad map view state and data
// Fetches all launch pads from SpaceX API for displaying on map
// Manages loading state and error handling
// @MainActor ensures all methods/properties are main-thread safe
@MainActor
final class LaunchPadMapViewModel: ObservableObject {
    @Published var launchPad: [Launchpad] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    // Async fetch
    func fetchLaunchPads() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let pads = try await LaunchPadService.shared.fetchAllLaunchPads()
            launchPad = pads
            isLoading = false
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
        }
    }
}
