import Foundation
import SwiftUI

class LaunchListViewModel: ObservableObject {
    @Published var launches: [Launch] = PreviewData.launches
    @Published var favorites: [String] = []
    

    init() {
        loadFavorites()
    }

    func fetchLaunches() {
        LaunchService.shared.fetchAllLaunches { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let launches):
                self.launches = launches.sorted { $0.date_utc > $1.date_utc }
            case .failure(let error):
                print("Error fetching launches: \(error.localizedDescription)")
            }
        }
    }

    func toggleFavorite(launchID: String) {
        favorites.contains(launchID) ? favorites.removeAll { $0 == launchID } : favorites.append(launchID)
        saveFavorites()
    }

    private func saveFavorites() {
        UserDefaults.standard.set(favorites, forKey: "FavoriteLaunches")
    }

    private func loadFavorites() {
        favorites = UserDefaults.standard.array(forKey: "FavoriteLaunches") as? [String] ?? []
    }

    // Optional: Filtered favorites
    var favoriteLaunches: [Launch] {
        launches.filter { favorites.contains($0.id) }
    }
}
