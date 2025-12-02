//
//  FoodItem.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 25/11/2025.
//
import Foundation

struct FoodItem: Identifiable, Codable {
    var id: UUID?
    var name: String
    var category: String
    
    var caloriesPer100g: Double
    var proteinPer100g: Double
    var carbsPer100g: Double
    var fatPer100g: Double
}

