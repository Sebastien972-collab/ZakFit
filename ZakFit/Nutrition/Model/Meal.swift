//
//  Meal.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 18/11/2025.
//

import Foundation

/// Represents a meal logged by the user in the ZakFit application.
struct Meal: Identifiable, Codable{
    let id: UUID
    let name: String
    var date: Date
    var type: TypeOfMeal
    var foods: [ConsumedFood]
    
    /// Automatically calculated total calories for this meal.
    var totalCalories: Int {
        foods.reduce(0) { $0 + $1.calories }
    }
    
    /// Total protein content for the meal (in grams).
    var totalProtein: Double {
        foods.reduce(0) { $0 + $1.protein }
    }
    
    /// Total carbohydrates for the meal (in grams).
    var totalCarbs: Double {
        foods.reduce(0) { $0 + $1.carbs }
    }
    
    /// Total fat content for the meal (in grams).
    var totalFat: Double {
        foods.reduce(0) { $0 + $1.fat }
    }
    
    init(
        id: UUID = UUID(),
        name: String,
        date: Date = .now,
        type: TypeOfMeal,
        foods: [ConsumedFood]
    ) {
        self.id = id
        self.name = name
        self.date = date
        self.type = type
        self.foods = foods
    }
}


extension Meal: Hashable, Equatable {
    static func == (lhs: Meal, rhs: Meal) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - Samples

extension Meal {
    static var carbonara: Meal {
        Meal(
            name: "Spaghetti alla Carbonara",
            type: .dinner,
            foods: [
                ConsumedFood(
                    name: "Spaghetti",
                    quantityInGrams: 100,
                    calories: 350,
                    protein: 12,
                    carbs: 72,
                    fat: 1.5
                ),
                ConsumedFood(
                    name: "Guanciale",
                    quantityInGrams: 50,
                    calories: 300,
                    protein: 9,
                    carbs: 0,
                    fat: 27
                ),
                ConsumedFood(
                    name: "Egg",
                    quantityInGrams: 60,
                    calories: 88,
                    protein: 7,
                    carbs: 0.5,
                    fat: 6.5
                ),
                ConsumedFood(
                    name: "Pecorino Romano",
                    quantityInGrams: 25,
                    calories: 100,
                    protein: 7,
                    carbs: 0,
                    fat: 8
                )
            ]
        )
    }
    
    static var pastaMeals: [Meal] {
        [
            // Carbonara
            Meal(
                name: "Spaghetti alla Carbonara",
                type: .dinner,
                foods: [
                    ConsumedFood(name: "Spaghetti", quantityInGrams: 100, calories: 350, protein: 12, carbs: 72, fat: 1.5),
                    ConsumedFood(name: "Guanciale", quantityInGrams: 50, calories: 300, protein: 9, carbs: 0, fat: 27),
                    ConsumedFood(name: "Egg", quantityInGrams: 60, calories: 88, protein: 7, carbs: 0.5, fat: 6.5),
                    ConsumedFood(name: "Pecorino Romano", quantityInGrams: 25, calories: 100, protein: 7, carbs: 0, fat: 8)
                ]
            ),
            
            // Pasta Bolognese
            Meal(
                name: "Penne alla Bolognese",
                type: .lunch,
                foods: [
                    ConsumedFood(name: "Penne", quantityInGrams: 120, calories: 420, protein: 14, carbs: 84, fat: 2),
                    ConsumedFood(name: "Beef Bolognese Sauce", quantityInGrams: 150, calories: 215, protein: 18, carbs: 8, fat: 12)
                ]
            ),
            
            // Pesto Pasta
            Meal(
                name: "Fusilli al Pesto",
                type: .dinner,
                foods: [
                    ConsumedFood(name: "Fusilli", quantityInGrams: 100, calories: 350, protein: 12, carbs: 72, fat: 1.5),
                    ConsumedFood(name: "Basil Pesto", quantityInGrams: 40, calories: 240, protein: 4, carbs: 4, fat: 22)
                ]
            ),
            
            // Pasta Alfredo
            Meal(
                name: "Tagliatelle Alfredo",
                type: .dinner,
                foods: [
                    ConsumedFood(name: "Tagliatelle", quantityInGrams: 120, calories: 420, protein: 14, carbs: 84, fat: 2),
                    ConsumedFood(name: "Cream Sauce", quantityInGrams: 80, calories: 260, protein: 4, carbs: 4, fat: 24)
                ]
            ),
            
            // Pasta Arrabbiata
            Meal(
                name: "Spaghetti all’Arrabbiata",
                type: .lunch,
                foods: [
                    ConsumedFood(name: "Spaghetti", quantityInGrams: 100, calories: 350, protein: 12, carbs: 72, fat: 1.5),
                    ConsumedFood(name: "Tomato Arrabbiata Sauce", quantityInGrams: 120, calories: 90, protein: 3, carbs: 14, fat: 2)
                ]
            )
        ]
    }
}
