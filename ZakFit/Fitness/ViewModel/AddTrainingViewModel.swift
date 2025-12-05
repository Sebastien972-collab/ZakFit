//
//  AddTrainingViewModel.swift
//  ZakFit
//
//  Created by Sébastien Daguin on 04/12/2025.
//


import Foundation
import SwiftUI

@Observable
final class AddTrainingViewModel {
    
   
    
    
    var selectedActivity: ActivityType = .running
    var date: Date = .now
    var startTime: Date = .now
    var durationMinutes: Int = 30
    var selectedIntensity: Intensity = .moderate
    var notes: String = ""
    
    // MARK: - State
    
    var isSaving: Bool = false
    var saveErrorMessage: String?
    
    // MARK: - Output calculé
    
    var estimatedCalories: Int? {
        // Modèle ultra simple : base en fonction du type + coefficient intensité
        let basePerMinute: Double = {
            switch selectedActivity {
            case .running:   return 10
            case .walking:   return 4
            case .cycling:   return 8
            case .strength:  return 7
            case .swimming:  return 9
            case .yoga:      return 3
            }
        }()
        
        let intensityFactor: Double = {
            switch selectedIntensity {
            case .low:      return 0.8
            case .moderate: return 1.0
            case .high:     return 1.2
            }
        }()
        
        guard durationMinutes > 0 else { return nil }
        
        let value = basePerMinute * intensityFactor * Double(durationMinutes)
        return Int(value.rounded())
    }
    
    // MARK: - Actions
    
    func saveTraining() async {
        isSaving = true
        saveErrorMessage = nil
        
        // Ici tu appelleras ton service réseau / stockage local
        // Exemple :
        // try await TrainingService.shared.create(...)
        let create = TrainingCreate(
            activityTypeID: UUID(uuidString: "04b38361-f1cf-4b1e-a413-aa7c0192b07f")!,
                   date: date,
                   durationMinutes: durationMinutes,
                   intensity: selectedIntensity.rawValue,
                   estimatedCalories: estimatedCalories,
                   notes: notes.isEmpty ? nil : notes
               )
               
               do {
                   _ = try await TrainingService.shared.createTraining(from: create)
                   isSaving = false
               } catch {
                   isSaving = false
                   saveErrorMessage = "Erreur lors de l’enregistrement : \(error.localizedDescription)"
               }
        
        isSaving = false
    }
}
