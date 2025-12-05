//
//  SettingsViewModel.swift
//  ZakFit
//
//  Created by Sébastien Daguin on 18/11/2025.
//

import Foundation
import HealthKit
import SwiftUI

@Observable
final class SettingsViewModel {
    
    // MARK: - HealthKit states
    var healthAuthorized: Bool = false
    
    // Permissions détaillées (utilisées dans la vue)
    var stepsEnabled: Bool = false
    var energyEnabled: Bool = false
    var exerciseEnabled: Bool = false
    var heartRateEnabled: Bool = false
    var sleepEnabled: Bool = false
    var weightEnabled: Bool = false
    
    private let healthStore = HealthKitManager.shared.store
    
    // MARK: - Notifications
    var notificationsEnabled: Bool = true
    
    // MARK: - Apparence & UI
    var darkMode: Bool = false
    var animationsEnabled: Bool = true
    
    // MARK: - Unités
    enum WeightUnit: String, CaseIterable {
        case kg = "kg"
        case lbs = "lbs"
    }
    
    var weightUnit: WeightUnit = .kg
    
    // MARK: - Init
    init() {
        Task { await updateHealthStatus() }
    }
    
    // MARK: - HealthKit Authorization
    func requestHealthAuthorization() {
        Task {
            do {
                try await HealthKitManager.shared.requestAuthorization()
                await updateHealthStatus()
                await MainActor.run {
                    self.updateDetailedPermissions()
                }
            } catch {
                print("Erreur HealthKit :", error)
            }
        }
    }
    
    // MARK: - Update Health Status
    func updateHealthStatus() async {
        let types = HealthKitManager.shared.readTypes
        
        let authorized = types.contains { type in
            switch type {
            case let quantity as HKQuantityType:
                return healthStore.authorizationStatus(for: quantity) == .sharingAuthorized
            default:
                return false
            }
        }
        
        await MainActor.run {
            self.healthAuthorized = authorized
            self.updateDetailedPermissions()   // <<< IMPORTANT
        }
    }
    // MARK: - Vérification détaillée des permissions HealthKit
    @MainActor
    func updateDetailedPermissions() {
        // Pas & distance
        if let stepsType = HKQuantityType.quantityType(forIdentifier: .stepCount) {
            stepsEnabled = healthStore.authorizationStatus(for: stepsType) == .sharingAuthorized
        }
        
        // Énergie active (kcal brûlées)
        if let energyType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned) {
            energyEnabled = healthStore.authorizationStatus(for: energyType) == .sharingAuthorized
        }
        
        // Minutes d'exercice
        if let exerciseType = HKQuantityType.quantityType(forIdentifier: .appleExerciseTime) {
            exerciseEnabled = healthStore.authorizationStatus(for: exerciseType) == .sharingAuthorized
        }
        
        // Fréquence cardiaque
        if let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate) {
            heartRateEnabled = healthStore.authorizationStatus(for: heartRateType) == .sharingAuthorized
        }
        
        // Sommeil
        if let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) {
            sleepEnabled = healthStore.authorizationStatus(for: sleepType) == .sharingAuthorized
        }
        
        // Poids / IMC
        if let weightType = HKQuantityType.quantityType(forIdentifier: .bodyMass) {
            weightEnabled = healthStore.authorizationStatus(for: weightType) == .sharingAuthorized
        }
    }
    
    // MARK: - Déconnexion
    func logout() {
        print("Déconnexion utilisateur…")
        // TODO: Supprimer le token, nettoyer la session, rediriger vers Login
    }
    
    // MARK: - Suppression du compte
    func deleteAccount() {
        print("Suppression du compte…")
        
    }
}
