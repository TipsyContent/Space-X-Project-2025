//
//  AuthManager.swift
//  Space X Project
//
//  Created by Tipsy on 04/12/2025.
//

import Foundation
import FirebaseAuth


final class AuthManager {
    
    static let shared = AuthManager()
    
    private init() {
        
    }
    
    // Create User Firebase
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    // Sign In
    func signIn(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    // Sign Out
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    // Get Current AuthUser
    func getCurrentUser() -> AuthDataResultModel? {
        guard let user = Auth.auth().currentUser else { return nil }
        return AuthDataResultModel(user: user)
    }
}
