//
//  LaunchRow.swift
//  Space X Project
//
//  Created by Tipsy on 02/12/2025.
//

import SwiftUI

struct LaunchRow: View {
    let launch: Launch

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: launch.links?.patch?.small ?? "")) { image in
                image.resizable()
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .frame(width: 50, height: 50)
            .cornerRadius(8)

            VStack(alignment: .leading) {
                Text(launch.name)
                    .font(.headline)
                    .foregroundColor(.white)

                Text(launch.dateFormatted)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.7))
                
                Text(successText)
                    .font(.footnote)
                    .foregroundColor(.white.opacity(0.7))
            }
            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.white.opacity(0.7))
                .font(.system(size: 16, weight: .medium))
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(hex: "045788"))
    }
    
    private var successText: String {
        if let success = launch.success {
            return success ? "Success" : "Failed"
        }
        return "Unknown"
    }
}


#Preview {
    LaunchRow(launch: PreviewData.launch)
        .preferredColorScheme(.dark)
        .padding()
}
