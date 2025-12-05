//
//  Colors.swift
//  Space X Project
//
//  Created by Tipsy on 02/12/2025.
//

import SwiftUI

// A extention made to allow Hex Codes to be used in SwiftUI as i find HEX codes easier to color with
// Allows the use of Color(Hex: "ffffff") in the app
extension Color {
    
    /// Parameter hex: A hex color string (With or without # prefix)
    /// Example format: "ffffff" or "#ffffff"
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet(charactersIn: "#"))
        let scanner = Scanner(string: hex)
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let red = Double((rgb >> 16) & 0xFF) / 255.0
        let green = Double((rgb >> 8) & 0xFF) / 255.0
        let blue = Double(rgb & 0xFF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}
