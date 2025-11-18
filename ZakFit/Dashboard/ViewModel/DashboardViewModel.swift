//
//  DashboardViewModel.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 18/11/2025.
//

import Foundation

@Observable
class DashboardViewModel {
    var lastMeal: [Meal] = []
    
    init() {
        fetchLastMeal()
    }
    
    func fetchLastMeal(){
        self.lastMeal = Meal.pastaMeals.suffix(3)
    }
}
