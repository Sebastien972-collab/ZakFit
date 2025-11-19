//
//  AuthVmExtensions.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 19/11/2025.
//

import SwiftUI

extension AuthenticationViewModel {

    enum PasswordStrength: String {
        case weak = "Faible"
        case medium = "Moyen"
        case strong = "Fort"

        var color: SwiftUI.Color {
            switch self {
            case .weak: return .red
            case .medium: return .orange
            case .strong: return .green
            }
        }
    }

    var passwordStrength: PasswordStrength {
        let length = password.count
        let hasNumber = password.rangeOfCharacter(from: .decimalDigits) != nil
        let hasUppercase = password.rangeOfCharacter(from: .uppercaseLetters) != nil
        let hasSpecial = password.rangeOfCharacter(from: .symbols) != nil ||
                         password.rangeOfCharacter(from: .punctuationCharacters) != nil

        // Score simple
        var score = 0
        if length >= 8 { score += 1 }
        if hasNumber { score += 1 }
        if hasUppercase { score += 1 }
        if hasSpecial { score += 1 }

        switch score {
        case 0...1: return .weak
        case 2...3: return .medium
        default: return .strong
        }
    }

    var passwordProgress: Double {
        switch passwordStrength {
        case .weak: return 0.33
        case .medium: return 0.66
        case .strong: return 1.0
        }
    }
}
