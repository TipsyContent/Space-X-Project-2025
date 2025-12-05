import Foundation
import FirebaseAuth
import Combine

// AuthStateManager
// Manager for Firebase Auth state
// Uses Firebase auth listener to auto update Login Status
@MainActor
final class AuthStateManager: ObservableObject {
    @Published var isLoggedIn: Bool = false
    private var authStateListener: AuthStateDidChangeListenerHandle?
    
    init() {
        checkAuthState()
        setupAuthStateListener()
    }
    
    // Check current auth state
    private func checkAuthState() {
        self.isLoggedIn = Auth.auth().currentUser != nil
        print("Auth state checked: isLoggedIn = \(self.isLoggedIn)")
    }
    
    // Setup Firebase auth listener
    private func setupAuthStateListener() {
        authStateListener = Auth.auth().addStateDidChangeListener { _, user in
            DispatchQueue.main.async {
                self.isLoggedIn = user != nil
                print("Auth state changed: isLoggedIn = \(self.isLoggedIn)")
            }
        }
    }
    
    // Sign out
    func logout() throws {
        try Auth.auth().signOut()
        self.isLoggedIn = false
    }
    
    deinit {
        if let listener = authStateListener {
            Auth.auth().removeStateDidChangeListener(listener)
        }
    }
}
