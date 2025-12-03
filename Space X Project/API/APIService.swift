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
                let decoded = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async { completion(.success(decoded)) }
            } catch {
                DispatchQueue.main.async { completion(.failure(error)) }
            }
        }.resume()
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
