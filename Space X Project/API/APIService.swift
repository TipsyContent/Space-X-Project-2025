//
//  APIService.swift
//  Space X Project
//
//  Created by Tipsy on 02/12/2025.
//

import Foundation

final class APIService {
    static let shared = APIService()
    private init() {}

    func fetchData<T: Codable>(from urlString: String, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async { completion(.failure(APIError.invalidURL)) }
            return
        }

        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                DispatchQueue.main.async { completion(.failure(error)) }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async { completion(.failure(APIError.noData)) }
                return
            }

            do {
                let decoder = JSONDecoder()
                // Problem with iso decoder
                decoder.dateDecodingStrategy = .iso8601
                let decoded = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async { completion(.success(decoded)) }
            } catch {
                DispatchQueue.main.async { completion(.failure(error)) }
            }

        }.resume()
    }
}

// MARK: - API Errors
enum APIError: Error, LocalizedError {
    case invalidURL
    case noData

    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .noData: return "No data returned from server"
        }
    }
}
