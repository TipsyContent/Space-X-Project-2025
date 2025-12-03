import Foundation

final class LaunchService {
    static let shared = LaunchService()
    private init() {}
    
    private let baseURL = "https://api.spacexdata.com/v5/launches"
    
    func fetchAllLaunches(completion: @escaping (Result<[Launch], Error>) -> Void) {
        APIService.shared.fetchData(from: baseURL, type: [Launch].self) { result in
            switch result {
            case .success(let launches):
                DispatchQueue.main.async {
                    let sorted = launches.sorted { $0.date_utc > $1.date_utc }
                    completion(.success(sorted))
                }
            case .failure(let error):
                DispatchQueue.main.async { completion(.failure(error)) }
            }
        }
    }
    
    func fetchLaunch(id: String, completion: @escaping (Result<Launch, Error>) -> Void) {
        let url = "\(baseURL)/\(id)"
        APIService.shared.fetchData(from: url, type: Launch.self, completion: completion)
    }
}
