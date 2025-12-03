//
//  SavedLaunchesListView.swift
//  Space X Project
//
//  Created by Tipsy on 02/12/2025.
//

import SwiftUI

struct SavedLaunchesListView: View {
    @ObservedObject var viewModel: SavedLaunchesViewModel
    @Binding var navigationPath: NavigationPath
    
    var body: some View {
        ZStack {
            Color(hex: "023E61").edgesIgnoringSafeArea(.all)
            
            if viewModel.isLoading {
                ProgressView()
                    .tint(.blue)
            } else if let error = viewModel.errorMessage {
                ErrorView(error: error)
            } else if viewModel.launches.isEmpty {
                VStack(spacing: 12) {
                    Image(systemName: "bookmark.slash")
                        .font(.system(size: 40))
                        .foregroundColor(.gray)
                    Text("No saved launches")
                        .foregroundColor(.white)
                }
            } else {
                List {
                    ForEach(viewModel.launches) { launch in
                        NavigationLink(value: launch) {
                            LaunchRow(launch: launch)
                        }
                        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .listRowSeparator(.visible)
                        .listRowBackground(Color(hex: "045788"))
                    }
                }
                .scrollContentBackground(.hidden)
                .listStyle(.plain)
            }
        }
    }
}

