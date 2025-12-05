//
//  TrainingService.swift
//  ZakFit
//
//  Created by Sébastien Daguin on 04/12/2025.
//

import Foundation
import SJDToolbox

// MARK: - Service

final class TrainingService {
    static let shared = TrainingService()
    
    private let networking: ZakFitNetworkingService = .shared
    private let security = KeychainManager.shared
    
    private var encoder: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        return encoder
    }
    
    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
    
    private init() {}
    
    // MARK: - Activity Types
    
    /// Récupère la liste des types d’activités.
    /// GET /activity-types
    func getActivityTypes(category: String? = nil) async throws -> [ActivityTypeResponse] {
        var endpoint = "activity-types"
        if let category {
            // Exemple: /activity-types?category=cardio
            endpoint += "?category=\(category.clearForUrl)"
        }
        
        let apiRequest = APIRequest(endpoint: endpoint, httpMethod: .GET)
        let token = try security.getToken()
        return try await networking.request(
            apiRequest,
            responseType: [ActivityTypeResponse].self,
            token: token
        )
    }
    
    // MARK: - Trainings (Activities)
    
    /// Récupère tous les entraînements de l’utilisateur connecté.
    /// GET /activities
    func getAllTrainings() async throws -> [TrainingResponse] {
        let apiRequest = APIRequest(endpoint: "activities", httpMethod: .GET)
        let token = try security.getToken()
        return try await networking.request(
            apiRequest,
            responseType: [TrainingResponse].self,
            token: token
        )
    }
    
    /// Crée un nouvel entraînement.
    /// POST /activities
    func createTraining(from training: TrainingCreate) async throws -> TrainingResponse {
        let body = try encoder.encode(TrainingCreateData(from: training))
        let apiRequest = APIRequest(
            endpoint: "activities",
            httpMethod: .POST,
            body: body
        )
        let token = try security.getToken()
        return try await networking.request(
            apiRequest,
            responseType: TrainingResponse.self,
            token: token
        )
    }
    
    /// Met à jour un entraînement existant.
    /// PUT /activities/:id
    func updateTraining(id: UUID, with update: TrainingUpdate) async throws -> TrainingResponse {
        let body = try encoder.encode(TrainingUpdateData(from: update))
        let apiRequest = APIRequest(
            endpoint: "activities/\(id.uuidString)",
            httpMethod: .PUT,
            body: body
        )
        let token = try security.getToken()
        return try await networking.request(
            apiRequest,
            responseType: TrainingResponse.self,
            token: token
        )
    }
    
    /// Supprime un entraînement.
    /// DELETE /activities/:id
    func deleteTraining(id: UUID) async throws {
        let apiRequest = APIRequest(
            endpoint: "activities/\(id.uuidString)",
            httpMethod: .DELETE
        )
        let token = try security.getToken()
        _ = try await networking.request(
            apiRequest,
            responseType: EmptyResponse.self,
            token: token
        )
    }
}

// MARK: - DTO côté app

/// Aligné sur ActivityTypeResponseDTO du backend
struct ActivityTypeResponse: Codable, Identifiable, Hashable {
    let id: UUID
    let name: String
    let category: String
    let defaultCaloriesPerMinute: Double?
}

/// Modèle utilisé dans l’app pour afficher un entraînement
struct TrainingResponse: Codable, Identifiable, Hashable {
    let id: UUID
    let activityTypeID: UUID
    let activityTypeName: String
    let activityTypeCategory: String
    
    let date: Date
    let durationMinutes: Int
    let caloriesBurned: Int?
    let intensity: String
    let notes: String?
}

/// Modèle de création utilisé par la vue (AddTrainingViewModel -> TrainingCreate)
struct TrainingCreate {
    let activityTypeID: UUID
    let date: Date
    let durationMinutes: Int
    let intensity: String
    let estimatedCalories: Int?
    let notes: String?
}

/// Modèle de mise à jour (champs optionnels)
struct TrainingUpdate {
    let activityTypeID: UUID?
    let date: Date?
    let durationMinutes: Int?
    let intensity: String?
    let caloriesBurned: Int?
    let notes: String?
}

// MARK: - DTO envoyés à l’API

/// Payload POST /activities
struct TrainingCreateData: Encodable {
    let activityTypeID: UUID
    let date: Date
    let durationMinutes: Int
    let intensity: String
    let caloriesBurned: Int?
    let notes: String?
    
    init(from create: TrainingCreate) {
        self.activityTypeID = create.activityTypeID
        self.date = create.date
        self.durationMinutes = create.durationMinutes
        self.intensity = create.intensity
        self.caloriesBurned = create.estimatedCalories
        self.notes = create.notes
    }
}

/// Payload PUT /activities/:id
struct TrainingUpdateData: Encodable {
    let activityTypeID: UUID?
    let date: Date?
    let durationMinutes: Int?
    let intensity: String?
    let caloriesBurned: Int?
    let notes: String?
    
    init(from update: TrainingUpdate) {
        self.activityTypeID = update.activityTypeID
        self.date = update.date
        self.durationMinutes = update.durationMinutes
        self.intensity = update.intensity
        self.caloriesBurned = update.caloriesBurned
        self.notes = update.notes
    }
}
