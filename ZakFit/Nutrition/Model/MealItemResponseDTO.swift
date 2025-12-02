//
//  MealItemResponseDTO.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 02/12/2025.
//

import Foundation
struct MealItemData: Codable {
    
    let id: UUID
    let mealID: UUID
    let foodID: UUID
    
    let quantity: Double
    let unit: String
    
    let calories: Double
    let protein: Double
    let carbs: Double
    let fat: Double
    
    init(from food: FoodItem, mealId: UUID) {
        self.id = .init()
        self.mealID = mealId
        self.foodID = food.id ?? .init()
        
        self.quantity = 1
        self.unit = "g"
        
        self.calories = food.caloriesPer100g
        self.protein = food.proteinPer100g
        self.carbs = food.carbsPer100g
        self.fat = food.fatPer100g
    }
    
}
