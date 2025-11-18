//
//  User.swift
//  ZakFit
//
//  Created by Assistant on 18/11/2025.
//

import Foundation

struct User: Identifiable, Codable, Sendable {
    
    // MARK: - Identité
    let id: UUID?
    var firstName: String
    var lastName: String
    var email: String
    
    // MARK: - Informations physiques
    var height: Double?            // en cm
    var weight: Double?            // en kg
    var dateOfBirth: Date?
    var gender: Gender?
    
    // MARK: - Objectifs
    var dailyCalorieGoal: Int?
    var weightGoal: Double?
    var activityGoalMinutes: Int?
    var activityGoalCalories: Int?
    var goalType: UserGoal         // Perte de poids / maintien / prise de masse
    
    // MARK: - Préférences utilisateur
    var prefersDarkMode: Bool
    var notificationsEnabled: Bool
    var healthKitEnabled: Bool
    
    // MARK: - Dates
    var createdAt: Date?
    var updatedAt: Date?
    
    // MARK: - Initialisation
    init(
        id: UUID? = nil,
        firstName: String,
        lastName: String,
        email: String,
        height: Double? = nil,
        weight: Double? = nil,
        dateOfBirth: Date? = nil,
        gender: Gender? = nil,
        dailyCalorieGoal: Int? = nil,
        weightGoal: Double? = nil,
        activityGoalMinutes: Int? = nil,
        activityGoalCalories: Int? = nil,
        goalType: UserGoal = .weightLossGradual ,
        prefersDarkMode: Bool = false,
        notificationsEnabled: Bool = true,
        healthKitEnabled: Bool = false,
        createdAt: Date? = nil,
        updatedAt: Date? = nil
    ) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.height = height
        self.weight = weight
        self.dateOfBirth = dateOfBirth
        self.gender = gender
        self.dailyCalorieGoal = dailyCalorieGoal
        self.weightGoal = weightGoal
        self.activityGoalMinutes = activityGoalMinutes
        self.activityGoalCalories = activityGoalCalories
        self.goalType = goalType
        self.prefersDarkMode = prefersDarkMode
        self.notificationsEnabled = notificationsEnabled
        self.healthKitEnabled = healthKitEnabled
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
