final class LaunchService {
    static let shared = LaunchService()
    private init() {}
    
    private let baseURL = "https://api.spacexdata.com/v5/launches"
    
    // Fetch all launches that have a crew
    func fetchAllLaunches() async throws -> [Launch] {
        let launches: [Launch] = try await APIService.shared.fetchData(from: baseURL, type: [Launch].self)
        
        // Filter launches with non-empty crew
        let crewed = launches.filter { !($0.crew?.isEmpty ?? true) }
        
        // Sort by date descending
        return crewed.sorted { $0.date_utc > $1.date_utc }
    }
    
    // Fetch a single launch by ID
    func fetchLaunch(id: String) async throws -> Launch {
        let url = "\(baseURL)/\(id)"
        return try await APIService.shared.fetchData(from: url, type: Launch.self)
    }
}
