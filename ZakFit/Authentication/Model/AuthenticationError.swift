//
//  AuthenticationError.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 20/11/2025.
//


import Foundation

enum AuthenticationError: LocalizedError, Equatable {
    
    // MARK: - Client-side validation errors
    case emptyField(String)
    case emptyEmail
    case invalidEmailFormat
    case emptyPassword
    case weakPassword
    
    // MARK: - Unknown / generic
    case unknown
    
    // MARK: - Localized descriptions
    var errorDescription: String? {
        switch self {
        
        case .emptyField(let field):
            return "Le champ \(field) ne peut pas être vide."
        case .emptyEmail:
            return "Veuillez saisir une adresse email."
            
        case .invalidEmailFormat:
            return "L’adresse email semble invalide."
            
        case .emptyPassword:
            return "Veuillez saisir un mot de passe."
            
        case .weakPassword:
            return "Le mot de passe doit contenir au moins 6 caractères."
        // Fallback
        case .unknown:
            return "Une erreur inattendue est survenue."
        }
    }
}
