//
//  CrewService.swift
//  Space X Project
//
//  Created by Tipsy on 02/12/2025.
//
import Foundation

final class CrewService {
    static let shared = CrewService()
    private init() {}
    
    func fetchCrew(id: String, completion: @escaping (Result<Crew, Error>) -> Void) {
        let url = "https://api.spacexdata.com/v4/crew/\(id)"
        APIService.shared.fetchData(from: url, type: Crew.self, completion: completion)
    }
}
