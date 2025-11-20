//
//  KeychainManager.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 20/11/2025.
//

import Foundation
import SJDToolbox

@MainActor
final class KeychainManager {
    
    static let shared = KeychainManager()
    private init() {}

    // MARK: - Constants
    private enum Keys {
        static let service = "com.zakfit.keychain"
        static let tokenAccount = "auth.jwt.token"
        static let userIdAccount = "auth.user.id"
    }

    // MARK: - SAVE TOKEN
    func saveToken(_ token: String) throws {
        try KeychainService.shared.saveString(
            token,
            service: Keys.service,
            account: Keys.tokenAccount
        )
    }

    // MARK: - READ TOKEN
    func getToken() throws -> String {
        try KeychainService.shared.readString(
            service: Keys.service,
            account: Keys.tokenAccount
        )
    }

    // MARK: - DELETE TOKEN
    func deleteToken() throws {
        try KeychainService.shared.delete(
            service: Keys.service,
            account: Keys.tokenAccount
        )
    }

}
    
  
