//
//  UserGoal.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 18/11/2025.
//

import Foundation

enum UserGoal: String, Codable, CaseIterable {
    
    // MARK: - Weight
    case weightLossGradual = "Perte de poids graduelle"
    case weightLossIntensive = "Perte de poids soutenue"
    case weightMaintenance = "Stabilisation du poids"
    case weightGainHealthy = "Prise de poids saine"
    
    // MARK: - Activity
    case increaseSteps = "Augmenter le nombre de pas"
    case improveCardio = "Améliorer la condition cardiovasculaire"
    case buildMuscle = "Développer la masse musculaire"
    case improveEndurance = "Augmenter l’endurance"
    case beMoreActive = "Être plus actif au quotidien"
    
    // MARK: - Nutrition
    case eatHealthier = "Améliorer la qualité de mon alimentation"
    case trackMeals = "Suivre mes repas quotidiennement"
    case reduceSugar = "Réduire ma consommation de sucre"
    case increaseProtein = "Augmenter mon apport en protéines"
    case balancedNutrition = "Atteindre une alimentation équilibrée"
    
    // MARK: - Wellbeing
    case improveSleep = "Améliorer mon sommeil"
    case reduceStress = "Réduire mon niveau de stress"
    case dailyRoutine = "Créer une routine plus régulière"
    
    // MARK: - Long Term
    case prepareCompetition = "Préparer un événement sportif"
    case longTermHealth = "Améliorer ma santé sur le long terme"
}

extension UserGoal {
    var category: GoalCategory {
        switch self {
        // Weight
        case .weightLossGradual,
             .weightLossIntensive,
             .weightMaintenance,
             .weightGainHealthy:
            return .weight
        
        // Activity
        case .increaseSteps,
             .improveCardio,
             .buildMuscle,
             .improveEndurance,
             .beMoreActive:
            return .activity
        
        // Nutrition
        case .eatHealthier,
             .trackMeals,
             .reduceSugar,
             .increaseProtein,
             .balancedNutrition:
            return .nutrition
        
        // Wellbeing
        case .improveSleep,
             .reduceStress,
             .dailyRoutine:
            return .wellbeing
        
        // Long Term
        case .prepareCompetition,
             .longTermHealth:
            return .longTerm
        }
    }
}
