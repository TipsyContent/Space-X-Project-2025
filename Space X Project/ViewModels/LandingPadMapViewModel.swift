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
    
    func fetchLandingPads() {
        isLoading = true
        errorMessage = nil
        
        LandingPadService.shared.fetchAllLandingPads { [weak self] result in
            DispatchQueue.main.async {
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
}