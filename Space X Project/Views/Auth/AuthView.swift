import SwiftUI

struct AuthView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("SpaceX App")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.white)
            
            Text("Log ind eller opret konto")
                .font(.caption)
                .foregroundColor(.white.opacity(0.7))
            
            NavigationLink {
                SignInEmailView()
            } label: {
                Text("Sign In With Email")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            NavigationLink {
                SignUpEmailView()
            } label: {
                Text("Sign Up With Email")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(10)
            }
            
            Button(action: testLogin) {
                Text("Test (Skip Login)")
                    .font(.caption)
                    .foregroundColor(.white)
                    .frame(height: 45)
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.6))
                    .cornerRadius(10)
            }
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: "023E61"))
        .navigationTitle("Authentication")
    }
    
    private func testLogin() {
        // Login with test user
        Task {
            do {
                let _ = try await AuthManager.shared.signIn(email: "test@example.com", password: "testUserEmail")
                print("Test login successful")
            } catch {
                print("Test login failed: \(error)")
            }
        }
    }
}

#Preview {
    NavigationStack {
        AuthView()
    }
    .preferredColorScheme(.dark)
}
