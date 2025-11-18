//
//  ConsumedFood.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 18/11/2025.
//

import Foundation

/// Represents a specific food item consumed as part of a meal.
struct ConsumedFood: Identifiable, Codable {
    let id: UUID
    var name: String
    var quantityInGrams: Double
    
    /// Nutritional values adjusted based on the consumed quantity.
    var calories: Int
    var protein: Double
    var carbs: Double
    var fat: Double
    
    init(
        id: UUID = UUID(),
        name: String,
        quantityInGrams: Double,
        calories: Int,
        protein: Double,
        carbs: Double,
        fat: Double
    ) {
        self.id = id
        self.name = name
        self.quantityInGrams = quantityInGrams
        self.calories = calories
        self.protein = protein
        self.carbs = carbs
        self.fat = fat
    }
}
