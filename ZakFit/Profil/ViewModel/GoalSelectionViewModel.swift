//
//  GoalSelectionViewModel.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 18/11/2025.
//

import Foundation

@Observable
final class GoalSelectionViewModel {
    var selectedGoal: UserGoal? = nil
    
    func saveGoal() {
        guard let selectedGoal else { return }
        print("Objectif choisi :", selectedGoal.rawValue)
        // Prochaine étape : sauvegarde locale ou appel API
    }
}
