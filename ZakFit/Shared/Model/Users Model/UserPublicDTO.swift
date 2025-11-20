//
//  UserPublicDTO.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 20/11/2025.
//

import Foundation

struct UserPublicData: Codable {
    let id: UUID?
    let firstName: String
    let lastName: String
    let email: String

    let heightCm: Double
    let initialWeightKg: Double
    let currentWeightKg: Double

    let dietPreference: String?
    let activityLevel: String
    
    let createdAt: Date?
    let updatedAt: Date?
    
}


