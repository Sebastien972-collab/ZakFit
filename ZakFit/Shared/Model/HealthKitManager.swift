//
//  HealthKitManager.swift
//  ZakFit
//
//  Created by Sébastien Daguin on 18/11/2025.
//

//
//  HealthKitManager.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 2025-11-18.
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

    // MARK: - FETCH: Pas du jour
    func stepsToday() async throws -> Double {
        guard let type = HKQuantityType.quantityType(forIdentifier: .stepCount) else { return 0 }

        let start = Calendar.current.startOfDay(for: .now)
        let predicate = HKQuery.predicateForSamples(withStart: start, end: .now)

        return try await withCheckedThrowingContinuation { continuation in
            let query = HKStatisticsQuery(
                quantityType: type,
                quantitySamplePredicate: predicate,
                options: .cumulativeSum
            ) { _, result, error in
                
                if let error { continuation.resume(throwing: error); return }
                let value = result?.sumQuantity()?.doubleValue(for: .count()) ?? 0
                continuation.resume(returning: value)
            }

            store.execute(query)
        }
    }

    // MARK: - FETCH: Calories actives du jour
    func activeEnergyToday() async throws -> Double {
        guard let type = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned) else { return 0 }

        let start = Calendar.current.startOfDay(for: .now)
        let predicate = HKQuery.predicateForSamples(withStart: start, end: .now)

        return try await withCheckedThrowingContinuation { continuation in
            let query = HKStatisticsQuery(
                quantityType: type,
                quantitySamplePredicate: predicate,
                options: .cumulativeSum
            ) { _, result, error in
                
                if let error { continuation.resume(throwing: error); return }
                let kcal = result?.sumQuantity()?.doubleValue(for: .kilocalorie()) ?? 0
                continuation.resume(returning: kcal)
            }

            store.execute(query)
        }
    }

    // MARK: - FETCH: Workouts
    func workouts() async throws -> [HKWorkout] {
        try await withCheckedThrowingContinuation { continuation in
            let query = HKSampleQuery(
                sampleType: .workoutType(),
                predicate: nil,
                limit: HKObjectQueryNoLimit,
                sortDescriptors: nil
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
        async let w = workouts()

        return try await HealthSnapshot(
            steps: steps,
            activeEnergy: energy,
            workouts: w
        )
    }
    func exerciseMinutesToday() async throws -> Double {
            guard let type = HKQuantityType.quantityType(forIdentifier: .appleExerciseTime) else { return 0 }

            let start = Calendar.current.startOfDay(for: .now)
            let predicate = HKQuery.predicateForSamples(withStart: start, end: .now)

            return try await withCheckedThrowingContinuation { continuation in
                let query = HKStatisticsQuery(
                    quantityType: type,
                    quantitySamplePredicate: predicate,
                    options: .cumulativeSum
                ) { _, result, error in
                    
                    if let error {
                        continuation.resume(throwing: error)
                        return
                    }
                    
                    // Apple stocke le temps d'exercice en minutes
                    let minutes = result?.sumQuantity()?.doubleValue(for: .minute()) ?? 0
                    continuation.resume(returning: minutes)
                }

                store.execute(query)
            }
        }
}

// MARK: - DTO Snapshot
struct HealthSnapshot: Sendable {
    let steps: Double
    let activeEnergy: Double
    let workouts: [HKWorkout]
}
