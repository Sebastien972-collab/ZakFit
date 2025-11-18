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
    var foods: [ConsumedFood] = []
    // Champs temporaires pour ajouter un aliment
    var tempName: String = ""
    var tempCalories: Int?
    
    var savedFoods: [ConsumedFood] = []
    
    func addFood() {
        guard !tempName.isEmpty,
              let kcals = tempCalories else { return }
        
        let food = ConsumedFood(id: .init(), name: tempName, quantityInGrams: 0, calories: 0, protein: 0, carbs: 0, fat: 0)
        
        foods.append(food)
        tempName = ""
        tempCalories = nil
    }
    
    func saveMeal() {
        guard mealName.isEmpty == false else {
            return
        }
        Meal(id: .init(), name: mealName, type: .breakfast, foods: foods)
    }
}
