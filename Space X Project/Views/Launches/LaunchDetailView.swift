import SwiftUI

struct LaunchDetailView: View {
    let launch: Launch

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(launch.name)
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)

                Text(launch.dateFormatted)
                    .font(.title3)
                    .foregroundColor(.white.opacity(0.7))

                Text(launch.success == true ? "Success" : launch.success == false ? "Failed" : "Unknown")
                    .font(.headline)
                    .foregroundColor(launch.success == true ? .green : launch.success == false ? .red : .yellow)

                Divider().background(Color.white.opacity(0.5))

                // Placeholder Sections
                SectionView(title: "Rocket", content: ["Rocket placeholder"])
                SectionView(title: "Capsules", content: ["Capsule placeholder"])
                SectionView(title: "Crew", content: ["Crew placeholder"])
                SectionView(title: "Payloads", content: ["Payload placeholder"])
                SectionView(title: "Launchpad", content: ["Launchpad placeholder"])
            }
            .padding()
        }
        .background(Color(hex: "023E61").edgesIgnoringSafeArea(.all))
        .navigationTitle("Launch Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// Reusable Section View
struct SectionView: View {
    let title: String
    let content: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
            ForEach(content, id: \.self) { item in
                Text(item)
                    .foregroundColor(.white.opacity(0.8))
            }
        }
    }
}

#Preview {
    NavigationStack { // Wrap in NavigationStack to see navigation bar
        LaunchDetailView(launch: PreviewData.launch)
    }
    .preferredColorScheme(.dark)
    .previewDevice("iPhone 14 Pro")
}
