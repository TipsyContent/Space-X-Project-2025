//
//  AuthStateManager.swift
//  Space X Project
//
//  Created by Tipsy on 04/12/2025.
//


import Foundation
import FirebaseAuth
import Combine

@MainActor
final class AuthStateManager: ObservableObject {
    @Published var isLoggedIn: Bool = false
    
    init() {
        checkAuthState()
        setupAuthStateListener()
    }
    
    private func checkAuthState() {
        self.isLoggedIn = Auth.auth().currentUser != nil
        print("Auth state checked: isLoggedIn = \(self.isLoggedIn)")
    }
    
    private func setupAuthStateListener() {
        Auth.auth().addStateDidChangeListener { _, user in
            DispatchQueue.main.async {
                self.isLoggedIn = user != nil
                print("Auth state changed: isLoggedIn = \(self.isLoggedIn)")
            }
        }
    }
    
    func logout() throws {
        try Auth.auth().signOut()
        self.isLoggedIn = false
    }
}
