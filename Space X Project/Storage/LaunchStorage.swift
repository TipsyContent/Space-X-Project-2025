import Foundation
import FirebaseFirestore
import FirebaseAuth

// MARK: - LaunchStorage with Firebase Firestore
// Gemmer launch IDs i Firebase Firestore (cloud)
// Valgt løsning: Firebase Firestore fordi:
// - Data synkroniseres automatisk på tværs af enheder
// - Cloud backup - data går ikke tabt
// - Brugerbundet - hver bruger ser kun sine egne gemte launches
final class LaunchStorage {
    static let shared = LaunchStorage()
    private init() {}
    
    private let db = Firestore.firestore()
    private let collectionName = "saved_launches"
    
    // MARK: - Save launch ID to Firestore
    func saveLaunchID(_ id: String) {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("Bruger ikke logget ind")
            return
        }
        
        let launchDoc = db.collection(collectionName).document(userId)
        
        launchDoc.updateData([
            "launchIds": FieldValue.arrayUnion([id])
        ]) { error in
            if error != nil {
                launchDoc.setData([
                    "launchIds": [id],
                    "createdAt": FieldValue.serverTimestamp()
                ])
            }
        }
    }
    
    // MARK: - Remove launch ID from Firestore
    func removeLaunchID(_ id: String) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        db.collection(collectionName).document(userId).updateData([
            "launchIds": FieldValue.arrayRemove([id])
        ]) { error in
            if let error = error {
                print("Error removing: \(error)")
            }
        }
    }
    
    // MARK: - Get saved launch IDs (Async)
    func getSavedLaunchIDs() async -> [String] {
        guard let userId = Auth.auth().currentUser?.uid else {
            return []
        }
        
        do {
            let snapshot = try await db.collection(collectionName).document(userId).getDocument()
            if let data = snapshot.data() {
                return data["launchIds"] as? [String] ?? []
            }
            return []
        } catch {
            print("Error getting launches: \(error)")
            return []
        }
    }
    
    // MARK: - Check if launch is saved
    func isLaunchSaved(_ id: String) async -> Bool {
        let ids = await getSavedLaunchIDs()
        return ids.contains(id)
    }
}
