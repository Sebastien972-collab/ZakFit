//
//  MealResponseDTO.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 02/12/2025.
//

import Foundation
struct MealData: Codable {
    let id: UUID?
    let userID: UUID
    let date: Date
    let type: String
    let totalCalories: Double
    let totalProtein: Double
    let totalCarbs: Double
    let totalFat: Double
    
    init(from meal: Meal) {
        self.id = meal.id
        self.userID = UserManager.shared.currentUser.id
        self.date = meal.date
        self.type = meal.type.rawValue
        self.totalCalories = Double(meal.totalCalories)
        self.totalProtein = meal.totalProtein
        self.totalCarbs = meal.totalCarbs
        self.totalFat = meal.totalFat
    }
}
