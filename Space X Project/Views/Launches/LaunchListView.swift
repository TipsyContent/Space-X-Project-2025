//
//  LaunchListView 2.swift
//  Space X Project
//
//  Created by Tipsy on 02/12/2025.
//
import SwiftUI

struct LaunchListView: View {
    @ObservedObject var viewModel: LaunchListViewModel
    @Binding var navigationPath: NavigationPath
    
    var body: some View {
        ZStack {
            Color(hex: "023E61").edgesIgnoringSafeArea(.all)
            
            if viewModel.isLoading && viewModel.launches.isEmpty {
                ProgressView()
                    .tint(.blue)
            } else if let error = viewModel.errorMessage {
                ErrorView(error: error)
            } else if viewModel.launches.isEmpty {
                Text("No launches available")
                    .foregroundColor(.white)
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

struct ErrorView: View {
    let error: String
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 40))
                .foregroundColor(.red)
            Text("Error loading launches")
                .font(.headline)
                .foregroundColor(.white)
            Text(error)
                .font(.caption)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

#Preview {
    let vm = LaunchListViewModel()
    vm.launches = PreviewData.launches
    
    return NavigationStack {
        LaunchListView(
            viewModel: vm,
            navigationPath: .constant(NavigationPath())
        )
    }
    .preferredColorScheme(.dark)
}
