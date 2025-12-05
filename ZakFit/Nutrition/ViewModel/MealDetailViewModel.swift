//
//  MealDetailViewModel.swift
//  ZakFit
//
//  Created by Sébastien Daguin on 05/12/2025.
//


import Foundation

@MainActor
@Observable
final class MealDetailViewModel {
    let meal: MealResponse
    
    init(meal: MealResponse) {
        self.meal = meal
    }
    
    // Données
    var items: [MealItemResponse] = []
    
    // State
    var isLoading: Bool = false
    var errorMessage: String?
    
    // Totaux calculés
    var totalCalories: Double {
        items.reduce(0) { $0 + $1.calories }
    }
    
    var totalProtein: Double {
        items.reduce(0) { $0 + $1.protein }
    }
    
    var totalCarbs: Double {
        items.reduce(0) { $0 + $1.carbs }
    }
    
    var totalFat: Double {
        items.reduce(0) { $0 + $1.fat }
    }
    
    // MARK: - Actions
    
    func loadItems() async {
        isLoading = true
        errorMessage = nil
        
        do {
            items = try await MealService.shared.getItemsForMeal(mealId: meal.id)
        } catch {
            errorMessage = error.localizedDescription
            print("Error loading meal items:", error)
        }
        
        isLoading = false
    }
}