//
//  RocketService.swift
//  Space X Project
//
//  Created by Tipsy on 02/12/2025.
//

import Foundation

final class RocketService {
    static let shared = RocketService()
    private init() {}
    
    func fetchRocket(id: String, completion: @escaping (Result<Rocket, Error>) -> Void) {
        let url = "https://api.spacexdata.com/v4/rockets/\(id)"
        APIService.shared.fetchData(from: url, type: Rocket.self, completion: completion)
    }
}
