//
//  AuthenticationView.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 19/11/2025.
//

import SwiftUI

struct AuthenticationView: View {
    @State var authVm: AuthenticationViewModel = AuthenticationViewModel()
    var body: some View {
        ScrollView {
            VStack {
                VStack(alignment: .center, spacing: 24) {
                    Image(.appIcon)
                        .resizable()
                        .frame(width: 96, height: 96)
                    Text("ZakFit")
                        .font(.title)
                        .fontWeight(.bold)
                    Text(authVm.selection.displayText)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    VStack(spacing: 20) {
                        if authVm.selection == .register {
                            CustomTextField(systemName: "person.fill", title: "Prénom", placeholder: "votre@email.com", text: $authVm.email)
                            CustomTextField(systemName: "person.fill", title: "Nom", placeholder: "votre@email.com", text: $authVm.email)
                        }
                        
                        CustomTextField(systemName: "mail.fill", title: "E-mail", placeholder: "votre@email.com", text: $authVm.email)
                        
                        CustomSecureField(title: "Mot de passe", placeholder: "Saisissez votre mot de passe", text: $authVm.password)
                        if authVm.selection == .register && !authVm.password.isEmpty {
                            VStack(alignment: .leading, spacing: 8) {
                                // Texte indicateur
                                Text("Sécurité du mot de passe : \(authVm.passwordStrength.rawValue)")
                                    .font(.caption)
                                    .foregroundStyle(authVm.passwordStrength.color)

                                // Barre de progression
                                ProgressView(value: authVm.passwordProgress)
                                    .tint(authVm.passwordStrength.color)
                                    .animation(.spring(), value: authVm.passwordProgress)
                            }
                            .padding(.horizontal)
                        }
                        if authVm.selection == .register {
                            CustomSecureField(title: "Confirmation de mot de passe", placeholder: "Saisissez votre mot de passe", text: $authVm.password)
                        }
                    }
                    .padding(.horizontal)
                    
                }
            }
            
        }
        .background {
            Color.customWhite.ignoresSafeArea(.all)
        }
    }
    
}

#Preview {
    AuthenticationView()
}
