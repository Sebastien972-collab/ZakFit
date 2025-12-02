//
//  FoodManager.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 25/11/2025.
//

import Foundation
import SJDToolbox

class FoodManager {
    static let shared = FoodManager()
    private init() {}
    let service = ZakFitNetworkingService.shared
    let secutity = KeychainManager.shared
    var foods: [FoodItem] = []
    
    
    func fetchFoods() async throws -> [FoodItem] {
        let apiRequest = APIRequest(endpoint: "foods", httpMethod: .GET)
        let token = try secutity.getToken()
        return try await service.request(apiRequest, responseType: [FoodItem].self, token: token)
    }
    
}
