//
//  ActivityType.swift
//  ZakFit
//
//  Created by Sébastien Daguin on 04/12/2025.
//


import Foundation
import SwiftUI

enum ActivityType: String, CaseIterable, Identifiable {
    case running = "Course"
    case walking = "Marche"
    case cycling = "Vélo"
    case strength = "Musculation"
    case swimming = "Natation"
    case yoga = "Yoga"
    
    var id: String { rawValue }
    
    var iconName: String {
        switch self {
        case .running:   return "figure.run"
        case .walking:   return "figure.walk"
        case .cycling:   return "bicycle"
        case .strength:  return "dumbbell.fill"
        case .swimming:  return "figure.pool.swim"
        case .yoga:      return "figure.mind.and.body"
        }
    }
}

enum Intensity: String, CaseIterable, Identifiable {
    case low = "Faible"
    case moderate = "Modérée"
    case high = "Élevée"
    
    var id: String { rawValue }
    
    var color: Color {
        switch self {
        case .low:      return .green
        case .moderate: return .yellow
        case .high:     return .red
        }
    }
}
