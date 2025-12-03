//
//  LaunchPadService.swift
//  Space X Project
//
//  Created by Tipsy on 03/12/2025.
//


import Foundation

final class LaunchPadService {
    static let shared = LaunchPadService()
    private init() {}
    
    func fetchLaunchPad(id: String, completion: @escaping (Result<Launchpad, Error>) -> Void) {
        let url = "https://api.spacexdata.com/v4/launchpads/\(id)"
        APIService.shared.fetchData(from: url, type: Launchpad.self, completion: completion)
    }
    
    func fetchAllLaunchPads(completion: @escaping (Result<[Launchpad], Error>) -> Void) {
        let url = "https://api.spacexdata.com/v4/launchpads"
        APIService.shared.fetchData(from: url, type: [Launchpad].self, completion: completion)
    }
}