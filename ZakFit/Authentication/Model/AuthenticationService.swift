//
//  AuthenticationService.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 20/11/2025.
//

import Foundation
import SJDToolbox

final class AuthenticationService {
    static let shared = AuthenticationService()
    private let networkService = ZakFitNetworkingService.shared
    private let keychainManager = KeychainManager.shared
    private init() {}
    
    func register(of user: RegisterData) async throws -> UserPublicData {
        let data = try JSONEncoder().encode(user)
        let request = APIRequest(endpoint: "/auth/register", httpMethod: .POST)
        let networkResponse = try await networkService.request(request, responseType: TokenResponse.self)
        
        try keychainManager.saveToken(networkResponse.token)
        
        let userRequest = APIRequest(endpoint: "/users/me", httpMethod: .GET)
        return try await networkService.request(userRequest, responseType: UserPublicData.self, token: networkResponse.token)
    }
    
    func login(of user: LoginData) async throws -> UserPublicData {
        let data = try JSONEncoder().encode(user)
        let request = APIRequest(endpoint: "/auth/login", httpMethod: .POST, body: data)
        let networkResponse = try await networkService.request(request, responseType: TokenResponse.self)
        
        try keychainManager.saveToken(networkResponse.token)
        
        let userRequest = APIRequest(endpoint: "/users/me", httpMethod: .GET)
        return try await networkService.request(userRequest, responseType: UserPublicData.self, token: networkResponse.token)
    }
}
