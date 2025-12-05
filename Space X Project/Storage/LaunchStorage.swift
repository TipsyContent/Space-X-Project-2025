import Foundation
import FirebaseFirestore
import FirebaseAuth

// LaunchStorage with Firebase Firestore
// Saves Launch IDS in Firebase firestore (Cloud)
//Reason for chosing Firebase firestore:
// - The Data of saved launches will be saved over multiple Devices instead of only the used device
// - Firebase Firestore Cloud Backup So data is not lost
// - User connected, users only see their own saved launches connected to their user
final class LaunchStorage {
    static let shared = LaunchStorage()
    private init() {}
    
    private let db = Firestore.firestore()
    private let collectionName = "saved_launches"
    
    // Save launch ID to Firestore
    func saveLaunchID(_ id: String) {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("User is not Logged In")
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
    
    // Remove launch ID from Firestore
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
    
    // Get saved launch IDs (Async)
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
    
    // Check if launch is saved
    func isLaunchSaved(_ id: String) async -> Bool {
        let ids = await getSavedLaunchIDs()
        return ids.contains(id)
    }
}
