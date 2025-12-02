//
//  LaunchListView.swift
//  Space X Project
//
//  Created by Tipsy on 02/12/2025.
//

import SwiftUI

import SwiftUI

struct LaunchListView: View {
    @EnvironmentObject var vm: LaunchListViewModel

    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.launches) { launch in
                    LaunchRow(launch: launch)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)) // full width
                        .listRowSeparator(.visible)
                        .listRowBackground(Color(hex: "045788")) // same background as row
                }
            }
            .scrollContentBackground(.hidden) // remove default gray/black list background
            .background(Color(hex: "023E61")) // your app background color
            .navigationTitle("SpaceX Launches")
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                vm.fetchLaunches()
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
                vm.launches = PreviewData.launches // placeholder data
                return vm
            }())
            .previewDevice("iPhone 14 Pro")
    }
}

