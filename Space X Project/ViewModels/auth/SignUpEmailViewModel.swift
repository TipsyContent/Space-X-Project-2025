//
//  SignUpEmailViewModel.swift
//  Space X Project
//
//  Created by Tipsy on 04/12/2025.
//


import SwiftUI
import FirebaseAuth
// ViewModel For handling Email/Password sign-up Logic
// manges Sign-up state, input validation and firebase auth
// @MainActor ensures all methods/properties are main-thread safe
@MainActor
final class SignUpEmailViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    // Validates password and email by if empty and a min of 6 characters
    func signUp() {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Email and Password cant be Empty"
            return
        }
        
        guard password.count >= 6 else {
            errorMessage = "Password needs to be at least 6 characters long"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let returnedUserData = try await AuthManager.shared.createUser(email: email, password: password)
                print("Signup Success: \(returnedUserData)")
                isLoading = false
            } catch {
                errorMessage = error.localizedDescription
                isLoading = false
                print("Signup Error: \(error)")
            }
        }
    }
}
