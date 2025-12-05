//
//  SignInEmailViewModel.swift
//  Space X Project
//
//  Created by Tipsy on 04/12/2025.
import SwiftUI
import FirebaseAuth

// ViewModel for handing Email/Password sign-in logic
// Manages Sign-in state, validation and firebase Auth
// Published properties should auto update when UI is changed
// @MainActor ensures all methods/properties are main-thread safe
@MainActor
final class SignInEmailViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isSignedIn = false
    
    // Sign in Function Validates Input and attempts to sign in user with firebase
    func signIn() {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Email og password må ikke være tomme"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        // Async firebase Sign In
        Task {
            do {
                let returnedUserData = try await AuthManager.shared.signIn(email: email, password: password)
                print("Sign In Success: \(returnedUserData)")
                self.isSignedIn = true
                isLoading = false
            } catch {
                errorMessage = error.localizedDescription
                isLoading = false
                print("Sign In Error: \(error)")
            }
        }
    }
}
