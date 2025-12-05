import Foundation

final class LandingPadService {
    static let shared = LandingPadService()
    private init() {}
    
    // Fetch a single landing pad async
    func fetchLandingPad(id: String) async throws -> LandingPad {
        let url = "https://api.spacexdata.com/v4/landpads/\(id)"
        return try await APIService.shared.fetchData(from: url, type: LandingPad.self)
    }
    
    // Fetch all landing pads async
    func fetchAllLandingPads() async throws -> [LandingPad] {
        let url = "https://api.spacexdata.com/v4/landpads"
        return try await APIService.shared.fetchData(from: url, type: [LandingPad].self)
    }
}
