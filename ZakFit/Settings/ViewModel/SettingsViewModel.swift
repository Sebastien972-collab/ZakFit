//
//  SettingsViewModel.swift
//  ZakFit
//
//  Created by Sébastien Daguin on 18/11/2025.
//

import Foundation
import HealthKit

@Observable
final class SettingsViewModel {
    
    // MARK: - Published States
    var healthAuthorized: Bool = false
    var notificationsEnabled: Bool = true
    var darkMode: Bool = false
    
    private let healthStore = HealthKitManager.shared.store
    
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
            } catch {
                print("Erreur HealthKit :", error)
            }
        }
    }
    
    // MARK: - Update Health Status
    func updateHealthStatus() async {
        let types = HealthKitManager.shared.readTypes
        
        let authorized = types.contains { type in
            guard let quantity = type as? HKQuantityType else { return false }
            return healthStore.authorizationStatus(for: quantity) == .sharingAuthorized
        }
        
        await MainActor.run {
            self.healthAuthorized = authorized
        }
    }
}
