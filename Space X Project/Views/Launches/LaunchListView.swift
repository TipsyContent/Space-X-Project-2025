//
//  LaunchListView.swift
//  Space X Project
//
//  Created by Tipsy on 02/12/2025.
//
import SwiftUI

struct LaunchListView: View {
    @EnvironmentObject var vm: LaunchListViewModel
    @State private var navigationPath = NavigationPath()

    var body: some View {
        NavigationStack(path: $navigationPath) {
            List {
                ForEach(vm.launches) { launch in
                    Button {
                        navigationPath.append(launch)
                    } label: {
                        LaunchRow(launch: launch)
                    }
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .listRowSeparator(.visible)
                    .listRowBackground(Color(hex: "045788"))
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color(hex: "023E61"))
            .navigationTitle("SpaceX Launches")
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                if vm.launches.isEmpty {
                    vm.launches = PreviewData.launches // placeholder data for instant preview
                }
                vm.fetchLaunches() // fetch API data
            }
            .navigationDestination(for: Launch.self) { launch in
                LaunchDetailView(launch: launch)
            }
        }
    }
}

struct LaunchListView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchListView()
            .preferredColorScheme(.dark)
            .environmentObject({
                let vm = LaunchListViewModel()
                vm.launches = PreviewData.launches
                return vm
            }())
            .previewDevice("iPhone 14 Pro")
    }
}
