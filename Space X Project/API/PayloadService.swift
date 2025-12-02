//
//  PayloadService.swift
//  Space X Project
//
//  Created by Tipsy on 02/12/2025.
//

import Foundation

final class PayloadService {
    static let shared = PayloadService()
    private init() {}
    
    func fetchPayload(id: String, completion: @escaping (Result<Payload, Error>) -> Void) {
        let url = "https://api.spacexdata.com/v4/payloads/\(id)"
        APIService.shared.fetchData(from: url, type: Payload.self, completion: completion)
    }
}
