//
//  UserUpdateData.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 20/11/2025.
//


import Foundation

struct UserUpdateData: Codable {
    let firstName: String?
    let lastName: String?
    let email: String?
    
    let heightCm: Double?
    let initialWeightKg: Double?
    let currentWeightKg: Double?
    
    let dietPreference: String?
    let activityLevel: String?
}