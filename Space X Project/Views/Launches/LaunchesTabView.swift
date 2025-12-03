//
//  LaunchesTabView.swift
//  Space X Project
//
//  Created by Tipsy on 02/12/2025.
//

import SwiftUI

struct LaunchesTabView: View {
    @StateObject var launchListVM = LaunchListViewModel()
    @StateObject var savedLaunchesVM = SavedLaunchesViewModel()
    @State private var showSavedOnly = false
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                Picker("View", selection: $showSavedOnly) {
                    Text("All Launches").tag(false)
                    Text("Saved Launches").tag(true)
                }
                .pickerStyle(.segmented)
                .padding()
                
                if showSavedOnly {
                    SavedLaunchesListView(
                        viewModel: savedLaunchesVM,
                        navigationPath: $navigationPath
                    )
                    .onAppear {
                        savedLaunchesVM.loadSavedLaunches()
                    }
                } else {
                    LaunchListView(
                        viewModel: launchListVM,
                        navigationPath: $navigationPath
                    )
                    .onAppear {
                        if launchListVM.launches.isEmpty {
                            launchListVM.fetchLaunches()
                        }
                    }
                }
            }
            .navigationTitle("SpaceX Launches")
            .navigationBarTitleDisplayMode(.large)
            .navigationDestination(for: Launch.self) { launch in
                LaunchDetailView(launch: launch)
            }
            .background(Color(hex: "023E61").edgesIgnoringSafeArea(.all))
        }
    }
}

#Preview {
    let vm = LaunchListViewModel()
    vm.launches = PreviewData.launches
    
    return NavigationStack {
        VStack {
            Picker("View", selection: .constant(false)) {
                Text("All Launches").tag(false)
                Text("Saved Launches").tag(true)
            }
            .pickerStyle(.segmented)
            .padding()
            
            LaunchListView(
                viewModel: vm,
                navigationPath: .constant(NavigationPath())
            )
        }
        .navigationTitle("SpaceX Launches")
        .navigationBarTitleDisplayMode(.large)
        .background(Color(hex: "023E61").edgesIgnoringSafeArea(.all))
    }
    .preferredColorScheme(.dark)
}
