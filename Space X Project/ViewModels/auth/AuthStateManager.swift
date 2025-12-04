import Foundation
import FirebaseAuth
import Combine

// MARK: - AuthStateManager
// Manager for Firebase authentication state
// Bruger Firebase Auth listener til at automatisk opdatere login status
@MainActor
final class AuthStateManager: ObservableObject {
    @Published var isLoggedIn: Bool = false
    private var authStateListener: AuthStateDidChangeListenerHandle?
    
    init() {
        checkAuthState()
        setupAuthStateListener()
    }
    
    // MARK: - Check current auth state
    private func checkAuthState() {
        self.isLoggedIn = Auth.auth().currentUser != nil
        print("Auth state checked: isLoggedIn = \(self.isLoggedIn)")
    }
    
    // MARK: - Setup Firebase auth listener
    private func setupAuthStateListener() {
        authStateListener = Auth.auth().addStateDidChangeListener { _, user in
            DispatchQueue.main.async {
                self.isLoggedIn = user != nil
                print("Auth state changed: isLoggedIn = \(self.isLoggedIn)")
            }
        }
    }
    
    // MARK: - Sign out
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
