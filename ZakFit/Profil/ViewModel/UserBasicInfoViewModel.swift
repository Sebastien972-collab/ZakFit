//
//  UserBasicInfoViewModel.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 18/11/2025.
//

import SwiftUI

@Observable
final class UserBasicInfoViewModel {
    
    var firstName: String = ""
    var lastName: String = ""
    var age: Int?
    var height: Double?
    var weight: Double?
    
    func save() {
        // Logique de sauvegarde / API / stockage local
        print("User saved:", firstName, lastName, age ?? 0, height ?? 0, weight ?? 0)
    }
    init() {
        let currentUser = UserManager.shared.currentUser
        firstName = currentUser.firstName
        lastName = currentUser.lastName
        age = 27
        height = currentUser.heightCm
        weight = currentUser.currentWeightKg
        
    }
}
