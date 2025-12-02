//
//  MealResponse.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 02/12/2025.
//


import Foundation

struct MealResponse: Codable, Identifiable {
    let id: UUID
    let date: Date
    let type: String
    let userID: String

    let totalCalories: Double
    let totalProtein: Double
    let totalCarbs: Double
    let totalFat: Double
}
