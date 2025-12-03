import SwiftUI
import MapKit

struct LandingPadMapView: View {
    @StateObject var viewModel: LandingPadMapViewModel = LandingPadMapViewModel()
    

    @State private var region: MKCoordinateRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 28.5, longitude: -80.5),
            span: MKCoordinateSpan(latitudeDelta: 40, longitudeDelta: 40)
        )
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: "023E61").edgesIgnoringSafeArea(.all)
                
                if viewModel.isLoading && viewModel.landingPads.isEmpty {
                    ProgressView()
                        .tint(.blue)
                } else if let error = viewModel.errorMessage, viewModel.landingPads.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.system(size: 40))
                            .foregroundColor(.red)
                        Text("Error loading landing pads")
                            .font(.headline)
                            .foregroundColor(.white)
                        Text(error)
                            .font(.caption)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                } else if viewModel.landingPads.isEmpty {
                    Text("No landing pads found")
                        .foregroundColor(.white)
                } else {
                    Map(position: .constant(.region(region))) {
                        ForEach(viewModel.landingPads) { pad in
                            Annotation(pad.name, coordinate: CLLocationCoordinate2D(latitude: pad.latitude, longitude: pad.longitude)) {
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
                    .mapStyle(.standard(elevation: .realistic))
                }
            }
            .navigationTitle("Landing Pads")
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                viewModel.fetchLandingPads()
            }
        }
    }
}
