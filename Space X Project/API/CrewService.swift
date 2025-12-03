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
    
    func fetchCrew(id: String) async throws -> Crew {
        let url = "https://api.spacexdata.com/v4/crew/\(id)"
        return try await APIService.shared.fetchData(from: url, type: Crew.self)
    }
}
