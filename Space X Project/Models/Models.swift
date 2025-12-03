import Foundation

struct Launch: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let date_utc: String
    let date_unix: Int?
    let date_local: String?
    let date_precision: String?
    let success: Bool?
    let upcoming: Bool?
    let rocket: String
    let links: Links?
    let crew: [CrewMember]?
    let capsules: [String]?
    let payloads: [String]?
    let launchpad: String?
    let details: String?
    let flight_number: Int?
    let cores: [Core]?
    let fairings: Fairings?
    
    // Additional fields from API that were missing
    let static_fire_date_utc: String?
    let static_fire_date_unix: Int?
    let tdb: Bool?
    let net: Bool?
    let window: Int?
    let failures: [Failure]?
    let ships: [String]?
    let auto_update: Bool?
    
    struct CrewMember: Codable, Hashable {
        let crew: String  // Crew ID
        let role: String
    }
    
    struct Failure: Codable, Hashable {
        let time: Int?
        let altitude: Int?
        let reason: String?
    }
    
    struct Fairings: Codable, Hashable {
        let reused: Bool?
        let recovery_attempt: Bool?
        let recovered: Bool?
        let ships: [String]?
    }
    
    struct Links: Codable, Hashable {
        let patch: Patch?
        let reddit: Reddit?
        let flickr: Flickr?
        let webcast: String?
        let youtube_id: String?
        let article: String?
        let wikipedia: String?
        let presskit: String?  // Added missing field
        
        struct Patch: Codable, Hashable {
            let small: String?
            let large: String?
        }
        
        struct Reddit: Codable, Hashable {
            let campaign: String?
            let launch: String?
            let media: String?
            let recovery: String?
        }
        
        struct Flickr: Codable, Hashable {
            let small: [String]?
            let original: [String]?
        }
    }
    
    struct Core: Codable, Hashable {
        let core: String
        let flight: Int?
        let gridfins: Bool?
        let legs: Bool?
        let reused: Bool?
        let landing_attempt: Bool?
        let landing_success: Bool?
        let landing_type: String?
        let landpad: String?
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
