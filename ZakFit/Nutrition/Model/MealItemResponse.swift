//
//  MealItemResponse.swift
//  ZakFit
//
//  Created by Sébastien Daguin on 05/12/2025.
//


import Foundation

struct MealItemResponse: Codable, Identifiable, Hashable {
    let id: UUID
    let mealID: UUID
    let foodID: UUID
    let foodName: String     // ✅ on récupère le nom
    
    let quantity: Double
    let unit: String
    
    let calories: Double
    let protein: Double
    let carbs: Double
    let fat: Double
}
