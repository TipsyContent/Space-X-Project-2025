//
//  AuthDataResultModel.swift
//  Space X Project
//
//  Created by Tipsy on 04/12/2025.
//

import Foundation
import FirebaseAuth

// AuthDataResult Model
// Used to pass user data between services and views
struct AuthDataResultModel {
    let uid: String
    let email: String?
    let photoUrl: String?
    
    /// Converts Firebase user properties to the app's data model
    /// - Parameter user: Firebase user object from firebaseAuth
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
    }
}
