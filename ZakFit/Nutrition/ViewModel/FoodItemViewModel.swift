//
//  FoodItemViewModel.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 25/11/2025.
//

import Foundation

@Observable
class FoodItemViewModel: Identifiable {
    var searchText: String = ""
    var selectedCategory = FoodCategory.fruit
    
    private var allFoods: [FoodItem] = []
    
    // MARK: - Computed
    
    var filteredFoods: [FoodItem] {
        allFoods.filter { $0.category == selectedCategory.rawValue }
    }
    
    
    func fetchFoods() async {
        do {
            allFoods = try await FoodManager.shared.fetchFoods()
        } catch  {
            print(error.localizedDescription)
        }
    }
}

   
