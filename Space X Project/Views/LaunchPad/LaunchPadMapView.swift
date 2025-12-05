import SwiftUI
import MapKit

// Displays a map with all launch pads as annotations
// Users can tap on an annotation to navigate to LaunchpadDetailView
struct LaunchPadMapView: View {
    @StateObject var viewModel: LaunchPadMapViewModel = LaunchPadMapViewModel()
    
    // Default region somewhat over the main Pads
    @State private var region: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 28.5, longitude: -80.5),
        span: MKCoordinateSpan(latitudeDelta: 40, longitudeDelta: 40)
    )
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: "023E61").edgesIgnoringSafeArea(.all)
                
                // Loading state: show progress indicator if data is loading and no pads yet
                if viewModel.isLoading && viewModel.launchPad.isEmpty {
                    ProgressView()
                        .tint(.blue)
                    
                    // Error state: show error message if fetching failed
                } else if let error = viewModel.errorMessage, viewModel.launchPad.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.system(size: 40))
                            .foregroundColor(.red)
                        Text("Error loading launch pads")
                            .font(.headline)
                            .foregroundColor(.white)
                        Text(error)
                            .font(.caption)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                } else if viewModel.launchPad.isEmpty {
                    Text("No launch pads found")
                        .foregroundColor(.white)
                    
                    // Map view with annotations for each launch pad
                } else {
                    Map(position: .constant(.region(region))) {
                        ForEach(viewModel.launchPad) { pad in
                            Annotation(pad.name, coordinate: CLLocationCoordinate2D(latitude: pad.latitude, longitude: pad.longitude)) {
                                NavigationLink(value: pad) {
                                    VStack(spacing: 4) {
                                        Image(systemName: "location.fill")
                                            .foregroundColor(.orange)
                                            .font(.system(size: 24))
                                        Text(pad.name)
                                            .font(.caption2)
                                            .foregroundColor(.white)
                                            .lineLimit(1)
                                    }
                                    .padding(8)
                                    .background(Color.black.opacity(0.7))
                                    .cornerRadius(8)
                                }
                            }
                        }
                    }
                    .mapStyle(.standard(elevation: .realistic))
                }
            }
            .navigationTitle("Launch Pads")
            .navigationBarTitleDisplayMode(.large)
            .navigationDestination(for: Launchpad.self) { pad in
                LaunchpadDetailView(launchpad: pad)
            }
            .navigationDestination(for: Launch.self) { launch in
                LaunchDetailView(launch: launch)
            }
            .task {
                await viewModel.fetchLaunchPads()
            }
        }
    }
}

#Preview {
    LaunchPadMapView()
        .preferredColorScheme(.dark)
}
