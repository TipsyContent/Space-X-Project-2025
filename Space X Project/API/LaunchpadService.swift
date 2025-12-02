//
//  LaunchpadService.swift
//  Space X Project
//
//  Created by Tipsy on 02/12/2025.
//
import Foundation

final class LaunchpadService {
    static let shared = LaunchpadService()
    private init() {}
    
    func fetchLaunchpad(id: String, completion: @escaping (Result<Launchpad, Error>) -> Void) {
        let url = "https://api.spacexdata.com/v4/landpads/\(id)"
        APIService.shared.fetchData(from: url, type: Launchpad.self, completion: completion)
    }
    
    func fetchAllLaunchpads(completion: @escaping (Result<[Launchpad], Error>) -> Void) {
        let url = "https://api.spacexdata.com/v4/landpads"
        APIService.shared.fetchData(from: url, type: [Launchpad].self, completion: completion)
    }
}
