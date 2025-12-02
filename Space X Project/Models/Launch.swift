import Foundation

struct Launch: Codable, Identifiable {
    let id: String
    let name: String
    let date_utc: String
    let success: Bool?
    let rocket: String
    let links: Links?

    struct Links: Codable {
        let patch: Patch?

        struct Patch: Codable {
            let small: String?
            let large: String?
        }
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
