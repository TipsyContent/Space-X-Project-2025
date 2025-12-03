import Foundation

struct PreviewData {
    static let launches = [
        Launch(
            id: "1",
            name: "Crew-5",
            date_utc: "2022-10-05T16:00:00.000Z",
            date_unix: 1664985600,
            date_local: "2022-10-05T12:00:00-04:00",
            date_precision: "hour",
            success: true,
            upcoming: false,
            rocket: "5e9d0d95eda69973a809d1ec",
            links: Launch.Links(
                patch: Launch.Links.Patch(
                    small: "https://images2.imgbox.com/eb/d8/D1Yywp0w_o.png",
                    large: "https://images2.imgbox.com/33/2e/k6VE4iYl_o.png"
                ),
                reddit: nil,
                flickr: nil,
                webcast: "https://youtu.be/5EwW8ZkArL4",
                youtube_id: "5EwW8ZkArL4",
                article: nil,
                wikipedia: "https://en.wikipedia.org/wiki/SpaceX_Crew-5",
                presskit: nil
            ),
            crew: [
                Launch.CrewMember(crew: "62dd7196202306255024d13c", role: "Commander")
            ],
            capsules: ["617c05591bad2c661a6e2909"],
            payloads: ["62dd73ed202306255024d145"],
            launchpad: "5e9e4502f509094188566f88",
            details: nil,
            flight_number: 187,
            cores: nil,
            fairings: Launch.Fairings(
                reused: true,
                recovery_attempt: true,
                recovered: true,
                ships: ["Ship1", "Ship2"]
            ),
            static_fire_date_utc: nil,
            static_fire_date_unix: nil,
            tdb: false,
            net: false,
            window: 0,
            failures: nil,
            ships: ["Ship1", "Ship2"],
            auto_update: true
        ),
        Launch(
            id: "2",
            name: "Starlink 4-19",
            date_utc: "2023-01-15T10:00:00.000Z",
            date_unix: 1673773200,
            date_local: "2023-01-15T05:00:00-05:00",
            date_precision: "hour",
            success: true,
            upcoming: false,
            rocket: "5e9d0d95eda69973a809d1ec",
            links: Launch.Links(
                patch: Launch.Links.Patch(
                    small: "https://images2.imgbox.com/eb/d8/D1Yywp0w_o.png",
                    large: "https://images2.imgbox.com/33/2e/k6VE4iYl_o.png"
                ),
                reddit: nil,
                flickr: nil,
                webcast: nil,
                youtube_id: nil,
                article: nil,
                wikipedia: nil,
                presskit: nil
            ),
            crew: nil,
            capsules: nil,
            payloads: ["62dd73ed202306255024d146"],
            launchpad: "5e9e4502f509094188566f88",
            details: nil,
            flight_number: 188,
            cores: nil,
            fairings: nil,
            static_fire_date_utc: nil,
            static_fire_date_unix: nil,
            tdb: false,
            net: false,
            window: 0,
            failures: nil,
            ships: nil,
            auto_update: true
        )
    ]

    
    static let launch = launches[0]
    
    static let rocket = Rocket(
        id: "5e9d0d95eda69973a809d1ec",
        name: "Falcon 9",
        type: "rocket",
        active: true,
        description: "Falcon 9 is a two-stage rocket designed and manufactured by SpaceX.",
        company: "SpaceX",
        country: "United States",
        height: Rocket.Dimension(meters: 70, feet: 229.6),
        diameter: Rocket.Dimension(meters: 3.7, feet: 12),
        mass: Rocket.Mass(kg: 549054, lb: 1207920),
        first_stage: nil,
        second_stage: nil,
        engines: nil,
        cost_per_launch: 50000000,
        success_rate_pct: 98,
        first_flight: "2010-06-04",
        flickr_images: ["https://farm1.staticflickr.com/929/28787338307_3453a11a77_b.jpg"],
        wikipedia: "https://en.wikipedia.org/wiki/Falcon_9"
    )
    
    static let crew = Crew(
        id: "62dd7196202306255024d13c",
        name: "Michael López-Alegría",
        agency: "Axiom Space",
        image: "https://i.imgur.com/60YDzr6.png",
        wikipedia: "https://en.wikipedia.org/wiki/Michael_L%C3%B3pez-Alegr%C3%ADa",
        status: "active",
        launches: ["61eefaa89eb1064137a1bd73"]
    )
    
    static let capsule = Capsule(
        id: "5e9e2c5df359188aba3b2676",
        serial: "C206",
        type: "Dragon 2.0",
        status: "active",
        reuse_count: 2,
        water_landings: 2,
        land_landings: 0,
        last_update: "Docked to ISS",
        launches: ["5eb87d46ffd86e000604b388"]
    )
    
    static let launchpads = [
        Launchpad(
            id: "5e9e4502f509092b78566f87",
            name: "VAFB SLC 4E",
            full_name: "Vandenberg Air Force Base Space Launch Complex 4E",
            locality: "Vandenberg Air Force Base",
            region: "California",
            timezone: "America/Los_Angeles",
            latitude: 34.632093,
            longitude: -120.610829,
            launch_attempts: 15,
            launch_successes: 15,
            status: "active",
            rockets: ["5e9d0d95eda69973a809d1ec"],
            launches: ["5eb87ce1ffd86e000604b334"]
        )
    ]
    
    static let landingPads = [
        LandingPad(
            id: "5e9e3033383ecbb9e534e7cc",
            name: "JRTI",
            full_name: "Just Read The Instructions",
            type: "ASDS",
            status: "active",
            locality: "Port Canaveral",
            region: "Florida",
            latitude: 28.4104,
            longitude: -80.6188,
            landing_attempts: 40,
            landing_successes: 39,
            wikipedia: "https://en.wikipedia.org/wiki/Autonomous_spaceport_drone_ship",
            details: "The third ASDS barge",
            launches: ["5eb87cf0ffd86e000604b343"]
        )
    ]
}
