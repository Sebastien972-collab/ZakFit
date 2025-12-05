//
//  HealthKitManager.swift
//  ZakFit
//
//  Created by Sébastien Daguin on 18/11/2025.
//

import Foundation
import HealthKit

@MainActor
final class HealthKitManager {
    static let shared = HealthKitManager()
    let store = HKHealthStore()

    private init() {}

    // MARK: - Types que ZakFit peut lire
    var readTypes: Set<HKObjectType> {
        [
            HKObjectType.quantityType(forIdentifier: .stepCount)!,
            HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
            HKObjectType.quantityType(forIdentifier: .basalEnergyBurned)!,
            HKObjectType.quantityType(forIdentifier: .heartRate)!,
            HKObjectType.quantityType(forIdentifier: .bodyMass)!,
            HKObjectType.quantityType(forIdentifier: .height)!,
            HKObjectType.quantityType(forIdentifier: .appleExerciseTime)!,
            HKObjectType.workoutType()
        ]
    }

    // MARK: - Autorisation
    func requestAuthorization() async throws {
        try await store.requestAuthorization(toShare: [], read: readTypes)
    }

    // --- Fonction Générique de Statistiques (Optimisation) ---
    
    /// Récupère la somme cumulative d'un type HKQuantity pour la journée en cours.
    /// - Parameters:
    ///   - typeIdentifier: L'identifiant du type de quantité (e.g., .stepCount).
    ///   - unit: L'unité de mesure pour la conversion (e.g., .count()).
    private func fetchCumulativeSum(for typeIdentifier: HKQuantityTypeIdentifier, unit: HKUnit) async throws -> Double {
        guard let type = HKQuantityType.quantityType(forIdentifier: typeIdentifier) else { return 0 }

        let start = Calendar.current.startOfDay(for: .now)
        let predicate = HKQuery.predicateForSamples(withStart: start, end: .now)

        return try await withCheckedThrowingContinuation { continuation in
            let query = HKStatisticsQuery(
                quantityType: type,
                quantitySamplePredicate: predicate,
                options: .cumulativeSum
            ) { _, result, error in
                
                if let error { continuation.resume(throwing: error); return }
                let value = result?.sumQuantity()?.doubleValue(for: unit) ?? 0
                continuation.resume(returning: value)
            }

            store.execute(query)
        }
    }
    
    // --- Utilisation de la fonction générique ---
    
    // MARK: - FETCH: Pas du jour
    func stepsToday() async throws -> Double {
        return try await fetchCumulativeSum(for: .stepCount, unit: .count())
    }

    // MARK: - FETCH: Calories actives du jour
    func activeEnergyToday() async throws -> Double {
        return try await fetchCumulativeSum(for: .activeEnergyBurned, unit: .kilocalorie())
    }

    // MARK: - FETCH: Minutes d'exercice
    func exerciseMinutesToday() async throws -> Double {
        return try await fetchCumulativeSum(for: .appleExerciseTime, unit: .minute())
    }

    // MARK: - FETCH: Workouts
    func workouts() async throws -> [HKWorkout] {
        
        let startOfToday = Calendar.current.startOfDay(for: .now)
        // Filtre les workouts uniquement pour aujourd'hui
        let predicate = HKQuery.predicateForSamples(withStart: startOfToday, end: .now, options: .strictStartDate)
        
        // Trie par date de fin descendante (plus récent en premier)
        let sortDescriptor = NSSortDescriptor(
            key: HKSampleSortIdentifierEndDate,
            ascending: false
        )
        
        return try await withCheckedThrowingContinuation { continuation in
            let query = HKSampleQuery(
                sampleType: .workoutType(),
                predicate: predicate, // Utilise le filtre du jour
                limit: HKObjectQueryNoLimit,
                sortDescriptors: [sortDescriptor]
            ) { _, samples, error in
                
                if let error { continuation.resume(throwing: error); return }
                let list = samples as? [HKWorkout] ?? []
                continuation.resume(returning: list)
            }

            store.execute(query)
        }
    }

    // MARK: - BACKGROUND UPDATES
    func enableBackgroundUpdates() async throws {
        // Mise à jour instantanée (iOS 17+)
        try await store.enableBackgroundDelivery(
            for: HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
            frequency: .immediate
        )
    }

    // MARK: - OBSERVER: Watcher de mise à jour en temps réel
    func observeEnergyUpdates(_ handler: @escaping @MainActor () -> Void) {
        guard let type = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned) else { return }

        let query = HKObserverQuery(
            sampleType: type,
            predicate: nil
        ) { _, _, error in
            
            if error == nil {
                Task { @MainActor in handler() }
            }
        }

        store.execute(query)
    }

    // MARK: - Raccourci global (pratique)
    func refreshAll() async throws -> HealthSnapshot {
        async let steps = stepsToday()
        async let energy = activeEnergyToday()
        async let minutes = exerciseMinutesToday()
        async let w = workouts()

        return try await HealthSnapshot(
            steps: steps,
            activeEnergy: energy,
            exerciseMinutes: minutes, // Ajout de la nouvelle donnée
            workouts: w
        )
    }
    func canUseHealthKit() -> Bool {
        HKHealthStore.isHealthDataAvailable()
    }
}

// MARK: - DTO Snapshot
// Mise à jour de la structure pour inclure les minutes d'exercice
struct HealthSnapshot: Sendable {
    let steps: Double
    let activeEnergy: Double
    let exerciseMinutes: Double
    let workouts: [HKWorkout]
}
