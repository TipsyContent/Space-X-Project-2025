//
//  LandingPadMapViewModel.swift
//  Space X Project
//
//  Created by Tipsy on 03/12/2025.
//


import Foundation

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
