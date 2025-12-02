//
//  LaunchService.swift
//  Space X Project
//
//  Created by Tipsy on 02/12/2025.
//

import Foundation


final class LaunchService {
    static let shared = LaunchService()
    private init() {}

    private let baseURL = "https://api.spacexdata.com/v5/launches"


    func fetchAllLaunches(completion: @escaping (Result<[Launch], Error>) -> Void) {
        APIService.shared.fetchData(from: baseURL, type: [Launch].self) { result in
            switch result {
            case .success(let launches):
                // Optional: only take first 20 for testing
                completion(.success(Array(launches.prefix(20))))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }


    func fetchLaunch(id: String, completion: @escaping (Result<Launch, Error>) -> Void) {
        let url = "\(baseURL)/\(id)"
        APIService.shared.fetchData(from: url, type: Launch.self, completion: completion)
    }


    func fetchLatestLaunch(completion: @escaping (Result<Launch, Error>) -> Void) {
        let url = "\(baseURL)/latest"
        APIService.shared.fetchData(from: url, type: Launch.self, completion: completion)
    }
}
