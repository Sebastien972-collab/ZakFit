//
//  TypeOfMeal.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 18/11/2025.
//


import SwiftUI

@Observable
final class AddMealViewModel {
    var mealName: String = ""
    var date: Date = Date()
    var type: TypeOfMeal = .lunch
    var foods: [FoodItem] = []
    // Champs temporaires pour ajouter un aliment
    var tempName: String = ""
    var tempCalories: Int?
    var totalCalories: Double { foods.reduce(0) { $0 + $1.caloriesPer100g } }
    
    
    var savedFoods: [ConsumedFood] = []
    
    func addFood(food: FoodItem) {
        foods.append(food)
    }
    @Sendable
    func saveMeal() async {
        var meal = Meal(id: .init(), name: mealName, type: .breakfast, foods: foods)
        meal.foods =  foods
        do {
            let meal = try await MealService.shared.createMeal(meal: meal)
            
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    func containsFood(named: String) -> Bool {
        foods.contains(where: { $0.name == named })
    }
    func remove(food: FoodItem) {
        foods.remove(at: foods.firstIndex(where: { $0.id == food.id })!)
    }
}
