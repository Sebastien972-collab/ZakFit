//
//  FoodCategory.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 24/11/2025.
//

import Foundation

enum FoodCategory: String, Codable, CaseIterable, Identifiable {
    case fruit          = "Fruit"
    case legume         = "Légume"
    case viande         = "Viande"
    case poisson        = "Poisson"
    case cereale        = "Céréale"
    case legumineuse    = "Légumineuse"
    case laitier        = "Laitier"
    case oleagineux     = "Oléagineux"
    case graines        = "Graines"
    case matiereGrasse  = "Matière grasse"
    case snack          = "Snack"
    case platPrepare    = "Plat préparé"
    case boisson        = "Boisson"
    case divers         = "Divers"
    
    var id: String { rawValue }
    
    /// Nom à afficher dans l’interface
    var displayName: String {
        rawValue
    }
    
    /// Nom de SF Symbol associé (optionnel, pratique pour l’UI)
    var sfSymbolName: String {
        switch self {
        case .fruit:         return "apple.logo"
        case .legume:        return "leaf"
        case .viande:        return "fork.knife"
        case .poisson:       return "fish"
        case .cereale:       return "takeoutbag.and.cup.and.straw"
        case .legumineuse:   return "leaf.circle"
        case .laitier:       return "carton"
        case .oleagineux:    return "circle.hexagonpath"
        case .graines:       return "circle.grid.2x2"
        case .matiereGrasse: return "drop.fill"
        case .snack:         return "cup.and.saucer"
        case .platPrepare:   return "fork.knife.circle"
        case .boisson:       return "wineglass"
        case .divers:        return "questionmark.circle"
        }
    }
}
