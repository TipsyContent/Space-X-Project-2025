import Foundation

struct PreviewData {
    static let launch = Launch(
        id: "12345",
        name: "Falcon 9 • Starlink 40",
        date_utc: "2023-01-03T14:55:00.000Z",
        success: true,
        rocket: "rocket-id-123",
        links: Launch.Links(
            patch: Launch.Links.Patch(
                small: "https://images2.imgbox.com/3c/0e/T8iJcSN3_o.png",
                large: nil
            )
        )
    )
    
    static let launch2 = Launch(
        id: "98765",
        name: "Falcon Heavy • Test Flight",
        date_utc: "2022-11-10T11:00:00.000Z",
        success: false,
        rocket: "rocket-id-456",
        links: Launch.Links(
            patch: Launch.Links.Patch(
                small: "https://images2.imgbox.com/40/e3/GypSkayF_o.png",
                large: nil
            )
        )
    )

    static let launches: [Launch] = [launch, launch2]
}
