import Foundation

final class LaunchService {
    static let shared = LaunchService()
    private init() {}
    
    private let baseURL = "https://api.spacexdata.com/v5/launches"
    
    // Fetch all Launches in async
    func fetchAllLaunches() async throws -> [Launch] {
        let launches: [Launch] = try await APIService.shared.fetchData(from: baseURL, type: [Launch].self)
        
        // Sort the Launches after day new to old
        return launches.sorted { $0.date_utc > $1.date_utc }
    }
    
    // Fetch Launch by ID async
    func fetchLaunch(id: String) async throws -> Launch {
        let url = "\(baseURL)/\(id)"
        return try await APIService.shared.fetchData(from: url, type: Launch.self)
    }
}

