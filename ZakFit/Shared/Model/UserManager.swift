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
    private(set) var currentUser: User?
    private let service: UserService = .shared
    
    
    
    func fetchProfil() async throws {
        self.currentUser = service.fetchProfile()
    }
}
