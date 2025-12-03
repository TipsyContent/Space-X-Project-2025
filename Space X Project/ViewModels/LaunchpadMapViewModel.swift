//
//  LaunchpadMapViewModel.swift
//  Space X Project
//
//  Created by Tipsy on 02/12/2025.
//

import Foundation

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
