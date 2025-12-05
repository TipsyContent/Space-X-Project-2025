//
//  CapsuleService.swift
//  Space X Project
//
//  Created by Tipsy on 02/12/2025.
//
import Foundation

final class CapsuleService {
    static let shared = CapsuleService()
    private init() {}
    
    // Fetch a single capsule async
    func fetchCapsule(id: String) async throws -> Capsule {
        let url = "https://api.spacexdata.com/v4/capsules/\(id)"
        return try await APIService.shared.fetchData(from: url, type: Capsule.self)
    }
}

