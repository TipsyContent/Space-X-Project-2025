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
    let crew: [LaunchCrew]?
    let capsules: [String]?
    let payloads: [String]?
    let launchpad: String?
    let details: String?
    let flight_number: Int?
    let cores: [Core]?
    let fairings: Fairings?
    
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
    
    struct LaunchCrew: Codable, Hashable {
        let crew: String
        let role: String
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

struct Rocket: Codable, Identifiable {
    let id: String
    let name: String
    let type: String?
    let active: Bool?
    let description: String?
    let company: String?
    let country: String?
    let height: Dimension?
    let diameter: Dimension?
    let mass: Mass?
    let first_stage: Stage?
    let second_stage: Stage?
    let engines: Engine?
    let cost_per_launch: Int?
    let success_rate_pct: Double?
    let first_flight: String?
    let flickr_images: [String]?
    let wikipedia: String?
    
    struct Dimension: Codable {
        let meters: Double?
        let feet: Double?
    }
    
    struct Mass: Codable {
        let kg: Double?
        let lb: Double?
    }
    
    struct Stage: Codable {
        let thrust_sea_level: Thrust?
        let thrust_vacuum: Thrust?
        let thrust: Thrust?
        let reusable: Bool?
        let engines: Int?
        let fuel_amount_tons: Double?
        let burn_time_sec: Int?
        let payloads: PayloadConfig?
        
        struct Thrust: Codable {
            let kN: Double?
            let lbf: Double?
        }
        
        struct PayloadConfig: Codable {
            let composite_fairing: Fairing?
            let option_1: String?
            
            struct Fairing: Codable {
                let height: Dimension?
                let diameter: Dimension?
                
                struct Dimension: Codable {
                    let meters: Double?
                    let feet: Double?
                }
            }
        }
    }
    
    struct Engine: Codable {
        let isp: ISP?
        let thrust_sea_level: Thrust?
        let thrust_vacuum: Thrust?
        let number: Int?
        let type: String?
        let version: String?
        let layout: String?
        let engine_loss_max: Int?
        let propellant_1: String?
        let propellant_2: String?
        let thrust_to_weight: Double?
        
        struct ISP: Codable {
            let sea_level: Int?
            let vacuum: Int?
        }
        
        struct Thrust: Codable {
            let kN: Double?
            let lbf: Double?
        }
    }
}

struct Capsule: Codable, Identifiable {
    let id: String
    let serial: String?
    let type: String?
    let status: String?
    let reuse_count: Int?
    let water_landings: Int?
    let land_landings: Int?
    let last_update: String?
    let launches: [String]?
}

struct Crew: Codable, Identifiable {
    let id: String
    let name: String
    let agency: String?
    let image: String?
    let wikipedia: String?
    let status: String?
    let launches: [String]?
}

struct Payload: Codable, Identifiable {
    let id: String
    let name: String?
    let type: String?
    let mass_kg: Double?
    let mass_lbs: Double?
}

struct Launchpad: Codable, Identifiable {
    let id: String
    let name: String
    let full_name: String?
    let locality: String?
    let region: String?
    let timezone: String?
    let latitude: Double
    let longitude: Double
    let launch_attempts: Int?
    let launch_successes: Int?
    let status: String?
    let rockets: [String]?
    let launches: [String]?
}

struct LandingPad: Codable, Identifiable {
    let id: String
    let name: String
    let full_name: String?
    let type: String?
    let status: String?
    let locality: String?
    let region: String?
    let latitude: Double
    let longitude: Double
    let landing_attempts: Int?
    let landing_successes: Int?
    let wikipedia: String?
    let details: String?
    let launches: [String]?
}
