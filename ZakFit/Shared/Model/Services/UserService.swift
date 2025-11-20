//
//  UserService.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 20/11/2025.
//

import Foundation

final class UserService {
    static let shared = UserService()
    private let networkService: ZakFitNetworkingService = .shared
    private let keychainManager: KeychainManager = .shared
    private init() {}
    
    func fetchProfile() async throws -> UserPublicData {
        let token = try keychainManager.getToken()
        let request = APIRequest(endpoint: "users/me", httpMethod: .GET)
        return try await networkService.request(request, responseType: UserPublicData.self, token: token)
    }
    func updateProfile(userData: UserPublicData) async throws -> UserPublicData {
        let token = try keychainManager.getToken()
        let data = try JSONEncoder().encode(userData)
        let request = APIRequest(endpoint: "users/update", httpMethod: .PUT, body: data)
        return try await networkService.request(request, responseType: UserPublicData.self, token: token)
    }
}
