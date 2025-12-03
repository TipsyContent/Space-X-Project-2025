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
    
    func fetchPayload(id: String) async throws -> Payload  {
        let url = "https://api.spacexdata.com/v4/payloads/\(id)"
        return try await APIService.shared.fetchData(from: url, type: Payload.self)
    }
}
