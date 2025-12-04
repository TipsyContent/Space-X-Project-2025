//
//  SignInEmailView.swift
//  Space X Project
//
//  Created by Tipsy on 04/12/2025.
//
import SwiftUI
import FirebaseAuth


struct SignInEmailView: View {
    @StateObject private var viewModel = SignInEmailViewModel()
    @EnvironmentObject var authStateManager: AuthStateManager
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Log ind på din konto")
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
