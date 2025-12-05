import Foundation

// APIService Class To Try Feach from URL Used by Diffrent FetchService Classes Async
final class APIService {
    static let shared = APIService()
    private init() {}
    
    func fetchData<T: Codable>(from urlString: String, type: T.Type) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }
        
        print("Try Fetching from: \(urlString)")
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // Check HTTP response
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.noData
        }
        
        print("The HTTP Status: \(httpResponse.statusCode)")
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw APIError.invalidURL
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let decodedData = try decoder.decode(T.self, from: data)
            print("Successfully decoded data")
            return decodedData
            // Catches for errors when fetching (DataCorrupted, KeyNotFound, TypeMismatch,ValueNotFound)
        } catch let DecodingError.dataCorrupted(context) {
            print("Data was corrupted: \(context.debugDescription)")
            print("Coding path: \(context.codingPath.map { $0.stringValue }.joined(separator: " -> "))")
            throw APIError.decodingError
        } catch let DecodingError.keyNotFound(key, context) {
            print("The Key not found: \(key.stringValue)")
            print("Context: \(context.debugDescription)")
            print("Coding path: \(context.codingPath.map { $0.stringValue }.joined(separator: " -> "))")
            throw APIError.decodingError
        } catch let DecodingError.typeMismatch(type, context) {
            print("The Type mismatch for type: \(type)")
            print("Context: \(context.debugDescription)")
            print("Coding path: \(context.codingPath.map { $0.stringValue }.joined(separator: " -> "))")
            throw APIError.decodingError
        } catch let DecodingError.valueNotFound(type, context) {
            print("Value not found for type: \(type)")
            print("Context: \(context.debugDescription)")
            print("Coding path: \(context.codingPath.map { $0.stringValue }.joined(separator: " -> "))")
            throw APIError.decodingError
        } catch {
            print("Decoding error: \(error.localizedDescription)")
            if let data = String(data: data, encoding: .utf8) {
                print("Raw response (first 1000 chars) To not Fill out The Terminal: \(data.prefix(1000))")
            }
            throw APIError.decodingError
        }
    }
}

// API error Enum
enum APIError: Error, LocalizedError {
    case invalidURL
    case noData
    case decodingError
    case networkError(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .noData: return "No data returned from server"
        case .decodingError: return "Failed to decode data"
        case .networkError(let message): return "Network error: \(message)"
        }
    }
}
