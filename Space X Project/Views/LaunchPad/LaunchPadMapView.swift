//
//  LaunchPadMapView.swift
//  Space X Project
//
//  Created by Tipsy on 03/12/2025.
//
import SwiftUI
import MapKit

struct LaunchPadMapView: View {
    @StateObject var viewModel: LaunchPadMapViewModel = LaunchPadMapViewModel()
    
    @State private var region: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 28.5, longitude: -80.5),
        span: MKCoordinateSpan(latitudeDelta: 40, longitudeDelta: 40)
    )
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: "023E61").edgesIgnoringSafeArea(.all)
                
                if viewModel.isLoading && viewModel.launchPad.isEmpty {
                    ProgressView()
                        .tint(.blue)
                } else if let error = viewModel.errorMessage, viewModel.launchPad.isEmpty {
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
                } else if viewModel.launchPad.isEmpty {
                    Text("No landing pads found")
                        .foregroundColor(.white)
                } else {
                    Map(position: .constant(.region(region))) {
                        ForEach(viewModel.launchPad) { pad in
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
            .task {
                await viewModel.fetchLaunchPads()
            }
        }
    }
}
