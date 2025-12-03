import SwiftUI

struct LaunchDetailView: View {
    @StateObject var viewModel: LaunchDetailViewModel
    @Environment(\.dismiss) var dismiss
    
    init(launch: Launch) {
        _viewModel = StateObject(wrappedValue: LaunchDetailViewModel(launch: launch))
    }
    
    var body: some View {
        ZStack {
            Color(hex: "023E61").edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    headerView
                    divider
                    saveButton
                    detailsSection
                    flightInfoSection
                    rocketSection
                    crewSection
                    launchpadSection
                    mediaSection
                }
                .padding()
            }
        }
        .navigationTitle("Launch Details")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadDetails()
        }
    }
    
    // MARK: - Subviews
    
    private var headerView: some View {
        HStack(alignment: .top, spacing: 16) {
            AsyncImage(url: URL(string: viewModel.launch.links?.patch?.large ?? "")) { image in
                image.resizable()
                    .scaledToFit()
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .frame(height: 100)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(viewModel.launch.name)
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                
                Text(viewModel.launch.dateFormatted)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.7))
                
                HStack {
                    Image(systemName: statusIcon)
                        .foregroundColor(statusColor)
                    Text(statusText)
                        .foregroundColor(.white)
                }
                .font(.caption)
            }
            
            Spacer()
        }
    }
    
    private var divider: some View {
        Divider().background(Color.white.opacity(0.3))
    }
    
    private var saveButton: some View {
        Button(action: { viewModel.toggleSave() }) {
            HStack {
                Image(systemName: viewModel.isSaved ? "bookmark.fill" : "bookmark")
                Text(viewModel.isSaved ? "Saved" : "Save Launch")
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
    }
    
    @ViewBuilder
    private var detailsSection: some View {
        if let details = viewModel.launch.details {
            LaunchDetailSectionView(title: "Details", content: [details])
        }
    }
    
    @ViewBuilder
    private var flightInfoSection: some View {
        if let flightNumber = viewModel.launch.flight_number {
            LaunchDetailSectionView(title: "Flight Info", content: ["Flight #\(flightNumber)"])
        }
    }
    
    @ViewBuilder
    private var rocketSection: some View {
        if let rocket = viewModel.rocket {
            LaunchDetailSectionView(title: "Rocket", content: buildRocketContent(rocket))
        }
    }
    
    @ViewBuilder
    private var crewSection: some View {
        if !viewModel.crew.isEmpty {
            LaunchDetailSectionView(
                title: "Crew",
                content: viewModel.crew.map { "\($0.name) - \($0.agency ?? "N/A")" }
            )
        }
    }
    
    @ViewBuilder
    private var launchpadSection: some View {
        if let launchpad = viewModel.launchpad {
            LaunchDetailSectionView(title: "Launchpad", content: buildLaunchpadContent(launchpad))
        }
    }
    
    @ViewBuilder
    private var mediaSection: some View {
        if viewModel.launch.links?.youtube_id != nil {
            LaunchDetailSectionView(title: "Media", content: ["Webcast available on YouTube"])
        }
    }
    
    // MARK: - Helpers
    
    private var statusIcon: String {
        if viewModel.launch.success == true {
            return "checkmark.circle.fill"
        } else if viewModel.launch.success == false {
            return "xmark.circle.fill"
        } else {
            return "questionmark.circle.fill"
        }
    }
    
    private var statusColor: Color {
        if viewModel.launch.success == true {
            return .green
        } else if viewModel.launch.success == false {
            return .red
        } else {
            return .yellow
        }
    }
    
    private var statusText: String {
        if let success = viewModel.launch.success {
            return success ? "Success" : "Failed"
        }
        return "Unknown"
    }
    
    private func buildRocketContent(_ rocket: Rocket) -> [String] {
        var content: [String] = ["Name: \(rocket.name)"]
        if let height = rocket.height?.meters {
            content.append("Height: \(String(format: "%.0f", height)) m")
        }
        if let mass = rocket.mass?.kg {
            content.append("Mass: \(String(format: "%.0f", mass)) kg")
        }
        if let cost = rocket.cost_per_launch {
            content.append("Cost: $\(cost / 1_000_000)M")
        }
        if let success = rocket.success_rate_pct {
            content.append("Success Rate: \(String(format: "%.0f", success))%")
        }
        return content
    }
    
    private func buildLaunchpadContent(_ launchpad: Launchpad) -> [String] {
        var content: [String] = [launchpad.name]
        if let locality = launchpad.locality {
            content.append("Location: \(locality)")
        }
        if let region = launchpad.region {
            content.append("Region: \(region)")
        }
        return content
    }
}

struct LaunchDetailSectionView: View {
    let title: String
    let content: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .foregroundColor(.cyan)
            
            VStack(alignment: .leading, spacing: 4) {
                ForEach(content, id: \.self) { item in
                    Text(item)
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.8))
                }
            }
            .padding(.leading, 8)
        }
        .padding()
        .background(Color(hex: "034B7A").opacity(0.6))
        .cornerRadius(8)
    }
}

#Preview {
    LaunchDetailView(launch: PreviewData.launch)
        .preferredColorScheme(.dark)
}
