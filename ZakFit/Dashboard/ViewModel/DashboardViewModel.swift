//
//  DashboardViewModel.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 18/11/2025.
//

import Foundation

@MainActor
@Observable
final class DashboardViewModel {
    var lastMeal: [MealResponse] = []
    var lastActivity: [TrainingResponse] = []
    
    func fetchLastMeal() async  {
        do {
            self.lastMeal = try await MealService.shared.getAllMeal()
        } catch  {
            print(error.localizedDescription)
        }
       
    }
    
    func fetchLastActivity() async {
        do {
            self.lastActivity = try await TrainingService.shared.getAllTrainings()
        } catch  {
            print(error.localizedDescription)
        }
    }
}
