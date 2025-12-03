import Foundation

@MainActor
final class LaunchDetailViewModel: ObservableObject {
    @Published var launch: Launch
    @Published var rocket: Rocket?
    @Published var crew: [Crew] = []
    @Published var launchpad: Launchpad?
    @Published var isLoading = false
    @Published var isSaved = false
    @Published var errorMessage: String?
    
    init(launch: Launch) {
        self.launch = launch
        self.isSaved = LaunchStorage.shared.isLaunchSaved(launch.id)
    }
    
    // Async load details
    func loadDetails() async {
        isLoading = true
        errorMessage = nil
        crew = []
        
        do {
            // Fetch Rocket
            async let rocketFetch = RocketService.shared.fetchRocket(id: launch.rocket)
            
            // Fetch Crew (if any)
            var crewMembers: [Crew] = []
            if let crewList = launch.crew, !crewList.isEmpty {
                crewMembers = try await withThrowingTaskGroup(of: Crew?.self) { group in
                    for crewMember in crewList {
                        group.addTask {
                            try? await CrewService.shared.fetchCrew(id: crewMember.crew)
                        }
                    }
                    var results: [Crew] = []
                    for try await result in group {
                        if let result = result {
                            results.append(result)
                        }
                    }
                    return results
                }
            }
            
            // Fetch Launchpad (if available)
            var launchpadData: Launchpad? = nil
            if let launchpadId = launch.launchpad {
                launchpadData = try await LaunchPadService.shared.fetchLaunchPad(id: launchpadId)
            }
            
            // Await rocket and assign all results
            rocket = try await rocketFetch
            crew = crewMembers
            launchpad = launchpadData
            isLoading = false
            
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
        }
    }
    
    func toggleSave() {
        if isSaved {
            LaunchStorage.shared.removeLaunchID(launch.id)
        } else {
            LaunchStorage.shared.saveLaunchID(launch.id)
        }
        isSaved.toggle()
    }
}
