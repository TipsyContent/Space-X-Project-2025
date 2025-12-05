import Foundation

// LaunchDetailViewModel
// ViewModel for the launch detail view
// Fetches related data (Rocket, Crew, Launchpad, Landing pad) async
// manages save/unsave launch func with firebase firestore
// @MainActor ensures all methods/properties are main-thread safe
@MainActor
final class LaunchDetailViewModel: ObservableObject {
    @Published var launch: Launch
    @Published var rocket: Rocket?
    @Published var crew: [Crew] = []
    @Published var launchpad: Launchpad?
    @Published var landingPad: LandingPad?
    @Published var isLoading = false
    @Published var isSaved = false
    @Published var errorMessage: String?
    
    init(launch: Launch) {
        self.launch = launch
        self.isSaved = false
        // Will check if saved when loadDetails is called
    }
    
    // Load all launch details
    func loadDetails() async {
        isLoading = true
        errorMessage = nil
        crew = []
        
        // Check if saved
        isSaved = await LaunchStorage.shared.isLaunchSaved(launch.id)
        
        do {
            // Fetch Rocket
            async let rocketFetch = RocketService.shared.fetchRocket(id: launch.rocket ?? "default")
            
            // Fetch Crew (if any)
            var crewMembers: [Crew] = []
            if let crewList = launch.crew, !crewList.isEmpty {
                crewMembers = try await withThrowingTaskGroup(of: Crew?.self) { group in
                    for crewMember in crewList {
                        group.addTask {
                            try? await CrewService.shared.fetchCrew(id: crewMember.crew ?? "")
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
            
            // Fetch Landing Pad (if available)
            var landingPadData: LandingPad? = nil
            if let cores = launch.cores, !cores.isEmpty {
                for core in cores {
                    if let landpadId = core.landpad {
                        landingPadData = try await LandingPadService.shared.fetchLandingPad(id: landpadId)
                        break
                    }
                }
            }
            
            // Await rocket and assign all results
            rocket = try await rocketFetch
            crew = crewMembers
            launchpad = launchpadData
            landingPad = landingPadData
            isLoading = false
            
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
        }
    }
    
    // Toggle save launch
    func toggleSave() {
        if isSaved {
            LaunchStorage.shared.removeLaunchID(launch.id)
        } else {
            LaunchStorage.shared.saveLaunchID(launch.id)
        }
        isSaved.toggle()
    }
}
