//
//  SignInEmailView.swift
//  Space X Project
//
//  Created by Tipsy on 04/12/2025.
//
import SwiftUI
import FirebaseAuth

// Email/password sign-in view for existing users
// Collects email and password input from user
// Validates input and authenticates with Firebase
// Automatically navigates to main app when login succeeds
struct SignInEmailView: View {
    
    // Handles validation, loading state, and Firebase authentication
    @StateObject private var viewModel = SignInEmailViewModel()
    
    // When Firebase detects successful login, AuthStateManager updates
    // This automatically triggers navigation from AuthView to ContentView
    @EnvironmentObject var authStateManager: AuthStateManager
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Log in to your Account")
                .font(.title2)
                .bold()
                .foregroundColor(.white)
                .padding(.bottom, 20)
            
            TextField("Email...", text: $viewModel.email)
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            SecureField("Password...", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            if let errorMessage = viewModel.errorMessage {
                VStack(alignment: .leading, spacing: 8) {
                    Image(systemName: "exclamationmark.circle")
                        .foregroundColor(.red)
                    Text(errorMessage)
                        .font(.caption)
                        .foregroundColor(.red)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.red.opacity(0.1))
                .cornerRadius(8)
            }
            
            Button(action: {
                viewModel.signIn()
            }) {
                if viewModel.isLoading {
                    ProgressView()
                        .tint(.white)
                } else {
                    Text("Sign In")
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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: "023E61"))
        .navigationTitle("Sign In")
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: viewModel.isSignedIn) { oldValue, newValue in
            if newValue {
                // AuthStateManager vil automatisk opdateres via Firebase listener
                print("Login successful, AuthStateManager will update automatically")
            }
        }
    }
}

#Preview {
    NavigationStack {
        SignInEmailView()
    }
    .preferredColorScheme(.dark)
}
