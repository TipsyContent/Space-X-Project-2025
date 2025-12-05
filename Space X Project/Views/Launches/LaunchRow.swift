//
//  LaunchRow 2.swift
//  Space X Project
//
//  Created by Tipsy on 02/12/2025.
//
import SwiftUI

// A single row representing a SpaceX launch in a list.
// Displays patch image, launch name, date, and flight success indicator.
struct LaunchRow: View {
    let launch: Launch
    
    var body: some View {
        HStack(spacing: 12) {
            // Launch patch image (fallback shown if unavailable)
            AsyncImage(url: URL(string: launch.links?.patch?.small ?? "")) { image in
                image.resizable()
                    .scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.3)
                    .overlay(Image(systemName: "photo").foregroundColor(.gray))
            }
            .frame(width: 50, height: 50)
            .cornerRadius(8)
            .clipped()
            
            // Launch Text info
            VStack(alignment: .leading, spacing: 4) {
                Text(launch.name)
                    .font(.headline)
                    .foregroundColor(.white)
                Text(launch.dateFormatted)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.7))
                Text(successBadge)
                    .font(.caption2)
                    .foregroundColor(successColor)
                    .fontWeight(.semibold)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.white.opacity(0.5))
        }
        .padding(12)
        .background(Color(hex: "045788"))
    }
    
    // Creates a readable success status string
    private var successBadge: String {
        if let success = launch.success {
            return success ? "✓ Success" : "✗ Failed"
        }
        return "Status Unknown"
    }
    
    // Sets the success text color
    private var successColor: Color {
        if let success = launch.success {
            return success ? .green : .red
        }
        return .yellow
    }
}

#Preview {
    LaunchRow(launch: PreviewData.launch)
        .preferredColorScheme(.dark)
        .padding()
}
