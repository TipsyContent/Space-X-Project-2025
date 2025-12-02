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
                DispatchQueue.main.async {
                    // Filter launches that have crew
                    let filtered = launches
                        .filter { launch in
                            if let crew = launch.crew {
                                return !crew.isEmpty
                            }
                            return false
                        }
                        .sorted { $0.date_utc > $1.date_utc }

                    completion(.success(filtered))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
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
