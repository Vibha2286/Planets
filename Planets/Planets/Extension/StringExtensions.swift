//
//  StringExtensions.swift
//  Planets
//
//  Created by Vibha Mangrulkar on 2021/11/24.
//

import Foundation

/// All string extensions
extension String {
    /// Get localized string
    /// - Parameters:
    ///   - bundle: Search in main bundle
    ///   - tableName: Search Localizable file
    /// - Returns: Localized string
    func localized (bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: "\(self)", comment: "")
    }
}
