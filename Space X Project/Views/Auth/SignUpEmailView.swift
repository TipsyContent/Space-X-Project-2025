//
//  SignInEmailView.swift
//  Space X Project
//
//  Created by Tipsy on 04/12/2025.
//

import SwiftUI


struct SignUpEmailView: View {
    @StateObject private var viewModel = SignUpEmailViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            TextField("Email...", text: $viewModel.email)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            SecureField("Password (min 6 tegn)...", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .font(.caption)
                    .foregroundColor(.red)
                    .padding()
            }
            
            Button(action: {
                viewModel.signUp()
            }) {
                if viewModel.isLoading {
                    ProgressView()
                        .tint(.white)
                } else {
                    Text("Sign Up")
                        .font(.headline)
                        .foregroundColor(.white)
                }
            }
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .cornerRadius(10)
            .disabled(viewModel.isLoading)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Sign Up With Email")
    }
}

#Preview {
    NavigationStack {
        SignUpEmailView()
    }
}
