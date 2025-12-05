//
//  UserManager.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 20/11/2025.
//

import Foundation

final class UserManager {
    static let shared = UserManager()
    private init() {}
    private(set) var currentUser: User = .guest
    private let service: UserService = .shared
    
    
    func fetchProfil() async throws {
        let userFetched = User(from: try await service.fetchProfile())
        self.currentUser = userFetched
    }
    
    func uppdateProfil(with user: User) async throws {
        
    }
    
    /// Déconnecte l'utilisateur courant et réinitialise l'état local
    func logout(callback: (() -> Void)? = nil) {
        do {
            try KeychainManager.shared.deleteToken()
        } catch  {
            print(error.localizedDescription)
        }
    }
}
