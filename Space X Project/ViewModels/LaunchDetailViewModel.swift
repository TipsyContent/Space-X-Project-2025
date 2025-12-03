//
//  LaunchDetailViewModel.swift
//  Space X Project
//
//  Created by Tipsy on 02/12/2025.
//

import Foundation

@MainActor
final class LaunchDetailViewModel: ObservableObject {
    @Published var launch: Launch
    @Published var rocket: Rocket?
    @Published var crew: [Crew] = []
    @Published var launchpad: Launchpad?
    @Published var isLoading = false
    @Published var isSaved = false
    @Published var errorMessage: String?
    
    init(launch: Launch) {
        self.launch = launch
        self.isSaved = LaunchStorage.shared.isLaunchSaved(launch.id)
    }
    
    func loadDetails() {
        isLoading = true
        errorMessage = nil
        let group = DispatchGroup()
        
        // Fetch Rocket
        group.enter()
        RocketService.shared.fetchRocket(id: launch.rocket) { [weak self] result in
            if case .success(let rocket) = result {
                self?.rocket = rocket
            }
            group.leave()
        }
        
        // Fetch Crew
        if let crew = launch.crew, !crew.isEmpty {
            for crewMember in crew {
                group.enter()
                CrewService.shared.fetchCrew(id: crewMember.crew) { [weak self] result in
                    if case .success(let crewData) = result {
                        self?.crew.append(crewData)
                    }
                    group.leave()
                }
            }
        }
        
        // Fetch Launchpad
        if let launchpadId = launch.launchpad {
            group.enter()
            LaunchPadService.shared.fetchLaunchPad(id: launchpadId) { [weak self] result in
                if case .success(let launchpad) = result {
                    self?.launchpad = launchpad
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            self?.isLoading = false
        }
    }
    
    func toggleSave() {
        if isSaved {
            LaunchStorage.shared.removeLaunchID(launch.id)
        } else {
            LaunchStorage.shared.saveLaunchID(launch.id)
        }
        isSaved.toggle()
    }
}
