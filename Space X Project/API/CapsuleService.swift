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
    
    func fetchCapsule(id: String, completion: @escaping (Result<Capsule, Error>) -> Void) {
        let url = "https://api.spacexdata.com/v4/capsules/\(id)"
        APIService.shared.fetchData(from: url, type: Capsule.self, completion: completion)
    }
}
