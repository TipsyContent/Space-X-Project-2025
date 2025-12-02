//
//  LaunchStorage.swift
//  Space X Project
//
//  Created by Tipsy on 02/12/2025.
//
import Foundation

final class LaunchStorage {
    static let shared = LaunchStorage()
    private init() {}
    
    private let key = "savedLaunchIDs"
    
    func saveLaunchID(_ id: String) {
        var saved = getSavedLaunchIDs()
        if !saved.contains(id) {
            saved.append(id)
            UserDefaults.standard.set(saved, forKey: key)
        }
    }
    
    func removeLaunchID(_ id: String) {
        var saved = getSavedLaunchIDs()
        saved.removeAll { $0 == id }
        UserDefaults.standard.set(saved, forKey: key)
    }
    
    func getSavedLaunchIDs() -> [String] {
        return UserDefaults.standard.stringArray(forKey: key) ?? []
    }
    
    func isLaunchSaved(_ id: String) -> Bool {
        return getSavedLaunchIDs().contains(id)
    }
}
