import Foundation

final class APIService {
    static let shared = APIService()
    private init() {}
    
    func fetchData<T: Codable>(from urlString: String, type: T.Type) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            // Throw the real decoding error to debug
            throw error
        }
    }

}

enum APIError: Error, LocalizedError {
    case invalidURL
    case noData
    case decodingError
    
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .noData: return "No data returned from server"
        case .decodingError: return "Failed to decode data"
        }
    }
}
