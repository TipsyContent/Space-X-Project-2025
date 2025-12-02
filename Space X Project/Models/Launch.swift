import Foundation

struct Launch: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let date_utc: String
    let success: Bool?
    let rocket: String
    let links: Links?
    let crew: [LaunchCrew]?

    struct Links: Codable, Hashable {
        let patch: Patch?

        struct Patch: Codable, Hashable {
            let small: String?
            let large: String?
        }
    }

    struct LaunchCrew: Codable, Hashable {
        let crew: String // ID of the crew member
        let role: String
    }

    var dateFormatted: String {
        let formatter = ISO8601DateFormatter()
        if let date = formatter.date(from: date_utc) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateStyle = .medium
            displayFormatter.timeStyle = .short
            return displayFormatter.string(from: date)
        }
        return date_utc
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Launch, rhs: Launch) -> Bool {
        lhs.id == rhs.id
    }
}

struct Rocket: Codable, Identifiable {
    let id: String
    let name: String
}

struct Capsule: Codable, Identifiable {
    let id: String
    let serial: String
}

struct Crew: Codable, Identifiable {
    let id: String
    let name: String
    let agency: String
}

struct Payload: Codable, Identifiable {
    let id: String
    let name: String
}

struct Launchpad: Codable, Identifiable {
    let id: String
    let name: String
    let locality: String
    let latitude: Double
    let longitude: Double
}
