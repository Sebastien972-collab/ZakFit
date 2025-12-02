//
//  AuthenticationViewModel.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 19/11/2025.
//


import Foundation
import SJDToolbox

@Observable
class AuthenticationViewModel {

    // MARK: - Fields
    var selection: AuthenticationSelection = .register
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var password: String = ""
    var confirmPassword: String = ""

    // MARK: - UI STATES
    var isLoading: Bool = false
    var showError: Bool = false
    var error: AuthenticationError = .unknown

    // MARK: - REGISTER
    func register(callback: (() -> Void)? = nil) async {
        isLoading = true
        do {
            defer { isLoading = false }
            try validateRegisterForm()

            let user = RegisterData(
                firstName: firstName,
                lastName: lastName,
                email: email,
                password: password
            )

            let response = try await AuthenticationService.shared.register(of: user)
            callback?()

        } catch let authError as AuthenticationError {
            launchError(authError)
        } catch {
            launchError(AuthenticationError.unknown)
        }
    }

    // MARK: - LOGIN
    func login(callback: (() -> Void)? = nil) async {
        isLoading = true
        do {
            defer { isLoading = false }
            try validateLoginForm()

            let loginData = LoginData(email: email, password: password)
            let response = try await AuthenticationService.shared.login(of: loginData)
            
            callback?()

        } catch let authError as AuthenticationError {
            launchError(authError)
        } catch {
            launchError(AuthenticationError.unknown)
        }

    }

    // MARK: - VALIDATION
    private func validateRegisterForm() throws {
        if firstName.isEmpty { throw  AuthenticationError.emptyField("Prénom")     }
        if lastName.isEmpty { throw AuthenticationError.emptyField("Nom") }
        if email.isEmpty { throw AuthenticationError.emptyEmail }
        if !email.isValidEmail { throw AuthenticationError.invalidEmailFormat }

        if password.isEmpty { throw AuthenticationError.emptyPassword }
        if password.count < 6 { throw AuthenticationError.weakPassword }
        if password != confirmPassword { throw AuthenticationError.emptyPassword }
    }

    private func validateLoginForm() throws {
        if email.isEmpty { throw AuthenticationError.emptyEmail }
        if !email.isValidEmail { throw AuthenticationError.invalidEmailFormat }
        if password.isEmpty { throw AuthenticationError.emptyPassword }
    }
    
    private func launchError(_ error: Error) {
        self.error = .unknown
        showError = true
    }
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
