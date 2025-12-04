//
//  SignUpEmailViewModel.swift
//  Space X Project
//
//  Created by Tipsy on 04/12/2025.
//


import SwiftUI
import FirebaseAuth

@MainActor
final class SignUpEmailViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func signUp() {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Email og password må ikke være tomme"
            return
        }
        
        guard password.count >= 6 else {
            errorMessage = "Password skal være mindst 6 tegn"
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
