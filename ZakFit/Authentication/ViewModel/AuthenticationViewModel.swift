//
//  AuthenticationViewModel.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 19/11/2025.
//

import Foundation

@Observable
class AuthenticationViewModel {
    var selection: AuthenticationSelection = .register
    var email: String = ""
    var password: String = ""
    
}

extension AuthenticationViewModel {
    enum AuthenticationSelection: String  {
        case login = "Bienvenue sur ZakFit 👋"
        case register = "Créer votre compte"
        var displayText: String {
            switch self {
            case .login:
                return "Bienvenue sur ZakFit 👋"
            case .register:
                return "Créer votre compte"
            }
        }
    }
    
    
}
