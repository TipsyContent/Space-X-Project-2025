import SwiftUI
import MapKit

struct LaunchpadDetailView: View {
    let launchpad: Launchpad
    @State private var launches: [Launch] = []
    @State private var isLoading = false
    @State private var errorMessage: String?
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color(hex: "023E61").edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Header
                    headerSection
                    
                    Divider().background(Color.white.opacity(0.3))
                    
                    // Launchpad Info
                    infoSection
                    
                    Divider().background(Color.white.opacity(0.3))
                    
                    // Launches from this pad
                    launchesSection
                }
                .padding()
            }
        }
        .navigationTitle(launchpad.name)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await loadLaunches()
        }
    }
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(launchpad.name)
                .font(.title2)
                .bold()
                .foregroundColor(.white)
            
            if let fullName = launchpad.full_name {
                Text(fullName)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.7))
            }
            
            HStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Status")
                        .font(.caption2)
                        .foregroundColor(.white.opacity(0.6))
                    Text(launchpad.status ?? "Unknown")
                        .font(.caption)
                        .foregroundColor(statusColor)
                        .bold()
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text("Success Rate")
                        .font(.caption2)
                        .foregroundColor(.white.opacity(0.6))
                    if let attempts = launchpad.launch_attempts, let successes = launchpad.launch_successes {
                        let rate = attempts > 0 ? Double(successes) / Double(attempts) * 100 : 0
                        Text("\(String(format: "%.0f", rate))%")
                            .font(.caption)
                            .foregroundColor(.green)
                            .bold()
                    } else {
                        Text("N/A")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.6))
                    }
                }
            }
            .padding()
            .background(Color(hex: "034B7A").opacity(0.6))
            .cornerRadius(8)
        }
    }
    
    private var infoSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Details")
                .font(.headline)
                .foregroundColor(.cyan)
            
            if let locality = launchpad.locality {
                infoRow(label: "City", value: locality)
            }
            
            if let region = launchpad.region {
                infoRow(label: "Region", value: region)
            }
            
            infoRow(label: "Latitude", value: String(format: "%.4f", launchpad.latitude))
            infoRow(label: "Longitude", value: String(format: "%.4f", launchpad.longitude))
            
            if let attempts = launchpad.launch_attempts {
                infoRow(label: "Launch Attempts", value: "\(attempts)")
            }
            
            if let successes = launchpad.launch_successes {
                infoRow(label: "Successful Launches", value: "\(successes)")
            }
            
            if let timezone = launchpad.timezone {
                infoRow(label: "Timezone", value: timezone)
            }
        }
        .padding()
        .background(Color(hex: "034B7A").opacity(0.6))
        .cornerRadius(8)
    }
    
    @ViewBuilder
    private var launchesSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Launches from this Pad")
                .font(.headline)
                .foregroundColor(.cyan)
            
            if isLoading {
                ProgressView()
                    .tint(.blue)
                    .frame(maxWidth: .infinity, alignment: .center)
            } else if let error = errorMessage {
                VStack(spacing: 8) {
                    Image(systemName: "exclamationmark.circle")
                        .foregroundColor(.red)
                    Text(error)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .center)
            } else if launches.isEmpty {
                Text("No launches from this pad")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.6))
                    .frame(maxWidth: .infinity, alignment: .center)
            } else {
                VStack(spacing: 8) {
                    ForEach(launches) { launch in
                        NavigationLink(value: launch) {
                            LaunchRow(launch: launch)
                        }
                    }
                }
            }
        }
        .padding()
        .background(Color(hex: "034B7A").opacity(0.6))
        .cornerRadius(8)
    }
    
    private func infoRow(label: String, value: String) -> some View {
        HStack {
            Text(label)
                .font(.caption)
                .foregroundColor(.white.opacity(0.6))
            Spacer()
            Text(value)
                .font(.caption)
                .foregroundColor(.white)
                .bold()
        }
        .padding(.vertical, 4)
    }
    
    private var statusColor: Color {
        guard let status = launchpad.status else { return .gray }
        switch status.lowercased() {
        case "active": return .green
        case "retired": return .red
        case "under construction": return .yellow
        default: return .gray
        }
    }
    
    private func loadLaunches() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let allLaunches = try await LaunchService.shared.fetchAllLaunches()
            self.launches = allLaunches.filter { launch in
                launch.launchpad == launchpad.id
            }
            .sorted { $0.date_utc > $1.date_utc }
            isLoading = false
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
        }
    }
}

#Preview {
    LaunchpadDetailView(launchpad: PreviewData.launchpads[0])
        .preferredColorScheme(.dark)
}
