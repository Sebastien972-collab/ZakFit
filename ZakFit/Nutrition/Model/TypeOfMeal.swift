//
//  TypeOfMeal.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 18/11/2025.
//

import Foundation


enum TypeOfMeal: String, CaseIterable, Codable {
    case breakfast = "Petit-déjeuner"
    case lunch = "Déjeuner"
    case dinner = "Dîner"
    
    var iconName: String {
        switch self {
        case .breakfast:
             "cup.and.saucer.fill"
        case .lunch:
             "sunrise.fill"
        case .dinner:
            "frying.pan.fill"
        }
    }
    var coulorName: String {
        switch self {
        case .breakfast:
            "breakfast"
        case .lunch:
            "lunch"
        case .dinner:
            "dinner"
        }
    }
}
