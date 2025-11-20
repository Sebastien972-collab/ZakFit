//
//  User.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN.
//

import Foundation

struct User: Identifiable, Codable, Equatable {

    // MARK: - Identité
    let id: UUID
    var firstName: String
    var lastName: String
    var email: String

    // MARK: - Mesures physiques
    var heightCm: Double
    var initialWeightKg: Double
    var currentWeightKg: Double

    // MARK: - Préférences
    var dietPreference: String
    var activityLevel: String

    // MARK: - Dates
    let createdAt: Date?
    let updatedAt: Date?
    
    // MARK: - Initializer
    init(
        id: UUID = UUID(),
        firstName: String,
        lastName: String,
        email: String,
        heightCm: Double,
        initialWeightKg: Double,
        currentWeightKg: Double,
        dietPreference: String,
        activityLevel: String,
        createdAt: Date = Date(),
        updatedAt: Date = Date()
    ) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.heightCm = heightCm
        self.initialWeightKg = initialWeightKg
        self.currentWeightKg = currentWeightKg
        self.dietPreference = dietPreference
        self.activityLevel = activityLevel
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    init(from userPublicData: UserPublicData) {
        self.id = userPublicData.id ?? UUID()
        self.firstName = userPublicData.firstName
        self.lastName = userPublicData.lastName
        self.email = userPublicData.email
        
        //MARK: - Mesures physiques
        self.heightCm = userPublicData.heightCm
        self.initialWeightKg = userPublicData.initialWeightKg
        self.currentWeightKg = userPublicData.currentWeightKg
        //MARK: - Préférences
        self.dietPreference = userPublicData.dietPreference ?? "none"
        self.activityLevel = userPublicData.activityLevel
        //MARK: - Dates
        self.createdAt = userPublicData.createdAt
        self.updatedAt = userPublicData.updatedAt
    }
    
}

extension User {
    static let guest: User = .init(firstName: "Invité", lastName: "Guest", email: "guest@guest.com", heightCm: 0, initialWeightKg: 0, currentWeightKg: 0, dietPreference: "none", activityLevel: "Normal")
}
