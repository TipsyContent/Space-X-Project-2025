import Foundation

final class LaunchPadService {
    static let shared = LaunchPadService()
    private init() {}
    
    // Fetch a single launch pad asynchronously
    func fetchLaunchPad(id: String) async throws -> Launchpad {
        let url = "https://api.spacexdata.com/v4/launchpads/\(id)"
        return try await APIService.shared.fetchData(from: url, type: Launchpad.self)
    }
    
    // Fetch all launch pads asynchronously
    func fetchAllLaunchPads() async throws -> [Launchpad] {
        let url = "https://api.spacexdata.com/v4/launchpads"
        return try await APIService.shared.fetchData(from: url, type: [Launchpad].self)
    }
}
