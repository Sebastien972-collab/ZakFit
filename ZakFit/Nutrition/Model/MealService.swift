//
//  MealService.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 02/12/2025.
//

import Foundation
import SJDToolbox


final class MealService {
    static let shared = MealService()
    private let networking: ZakFitNetworkingService = .shared
    private var encoder: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        return encoder
    }
    let secutity = KeychainManager.shared
    private init(){}
    
    
    
    
    func getAllMeal() async throws -> [MealResponse] {
        let apiRequest = APIRequest(endpoint: "meals", httpMethod: .GET )
        let token = try secutity.getToken()
        return try await networking.request(apiRequest, responseType: [MealResponse].self, token: token)
    }
    func createMeal(meal: Meal) async throws -> Meal {
        let mealData = try encoder.encode(MealData(from: meal))
        let apiRequest = APIRequest(endpoint: "meals", httpMethod: .POST, body: mealData )
        let token = try secutity.getToken()
        let mealResponse = try await networking.request(apiRequest, responseType: Meal.self, token: token)
        if meal.foods.isNotEmpty {
            try await addItemsToMeal(mealItem: meal.foods, mealId: mealResponse.id)
        }
        return mealResponse
    }
    
    func addItemToMeal(mealItem: FoodItem, mealId: UUID) async throws {
        let mealItemData = try encoder.encode(MealItemData(from: mealItem, mealId: mealId))
        print("Item envoyé: \(mealItemData)")
        let apiRequest = APIRequest(endpoint: "meal-items", httpMethod: .POST, body: mealItemData )
        let token = try secutity.getToken()
        _ = try await networking.request(apiRequest, responseType: MealItemData.self, token: token)
    }
    func addItemsToMeal(mealItem: [FoodItem], mealId: UUID) async throws {
        let mealItemData = try encoder.encode(mealItem.map { MealItemData(from: $0, mealId: mealId)})
        print("Item envoyé: \(mealItemData)")
        let apiRequest = APIRequest(endpoint: "meal-items/all", httpMethod: .POST, body: mealItemData )
        let token = try secutity.getToken()
        _ = try await networking.request(apiRequest, responseType: MealItemData.self, token: token)
    }
}
