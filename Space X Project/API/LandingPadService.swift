import Foundation

final class LandingPadService {
    static let shared = LandingPadService()
    private init() {}
    
    func fetchLandingPad(id: String, completion: @escaping (Result<LandingPad, Error>) -> Void) {
        let url = "https://api.spacexdata.com/v4/landpads/\(id)"
        APIService.shared.fetchData(from: url, type: LandingPad.self, completion: completion)
    }
    
    func fetchAllLandingPads(completion: @escaping (Result<[LandingPad], Error>) -> Void) {
        let url = "https://api.spacexdata.com/v4/landpads"
        APIService.shared.fetchData(from: url, type: [LandingPad].self, completion: completion)
    }
}
