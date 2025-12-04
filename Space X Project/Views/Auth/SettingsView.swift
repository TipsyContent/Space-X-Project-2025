import SwiftUI
import FirebaseAuth

struct SettingsView: View {
    @EnvironmentObject var authStateManager: AuthStateManager
    @State private var errorMessage: String?
    @State private var currentUser: AuthDataResultModel?
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: "023E61").edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    // User Info
                    if let user = currentUser {
                        VStack(spacing: 12) {
                            Image(systemName: "person.circle.fill")
                                .font(.system(size: 50))
                                .foregroundColor(.cyan)
                            
                            Text("Logged In")
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            Text(user.email ?? "No email")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.7))
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "034B7A").opacity(0.6))
                        .cornerRadius(12)
                    }
                    
                    // Sign Out Button
                    Button(action: {
                        signOut()
                    }) {
                        HStack {
                            Image(systemName: "arrow.left.circle.fill")
                            Text("Sign Out")
                                .font(.headline)
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(Color.red)
                        .cornerRadius(10)
                    }
                    
                    if let error = errorMessage {
                        VStack(alignment: .leading, spacing: 8) {
                            Image(systemName: "exclamationmark.circle")
                                .foregroundColor(.red)
                            Text(error)
                                .font(.caption)
                                .foregroundColor(.red)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.red.opacity(0.1))
                        .cornerRadius(8)
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                loadUserInfo()
            }
        }
    }
    
    private func loadUserInfo() {
        currentUser = AuthManager.shared.getCurrentUser()
    }
    
    private func signOut() {
        do {
            try authStateManager.logout()
        } catch {
            errorMessage = error.localizedDescription
            print("Sign out error: \(error)")
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(AuthStateManager())
        .preferredColorScheme(.dark)
}
