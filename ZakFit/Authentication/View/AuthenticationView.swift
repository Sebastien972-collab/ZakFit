//
//  AuthenticationView.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 19/11/2025.
//

import SwiftUI

struct AuthenticationView: View {

    @State var authVm = AuthenticationViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: 32) {

                // MARK: - Header
                VStack(spacing: 16) {
                    Image(.appIcon)
                        .resizable()
                        .frame(width: 96, height: 96)

                    Text("ZakFit")
                        .font(.title)
                        .fontWeight(.bold)

                    Text(authVm.selection.displayText)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                // MARK: - Form
                VStack(spacing: 20) {

                    if authVm.selection == .register {
                        CustomTextField(systemName: "person.fill",
                                        title: "Prénom",
                                        placeholder: "Votre prénom",
                                        text: $authVm.firstName)

                        CustomTextField(systemName: "person.fill",
                                        title: "Nom",
                                        placeholder: "Votre nom",
                                        text: $authVm.lastName)
                    }

                    CustomTextField(systemName: "mail.fill",
                                    title: "E-mail",
                                    placeholder: "votre@email.com",
                                    text: $authVm.email)

                    CustomSecureField(title: "Mot de passe",
                                      placeholder: "Saisissez votre mot de passe",
                                      text: $authVm.password)

                    if authVm.selection == .register {
                        CustomSecureField(title: "Confirmation",
                                          placeholder: "Confirmez votre mot de passe",
                                          text: $authVm.confirmPassword)
                    }

                    // MARK: - Button
                    Button {
                        Task {
                            if authVm.selection == .login {
                                await authVm.login()
                            } else {
                                await authVm.register()
                            }
                        }
                    } label: {
                        HStack {
                            if authVm.isLoading {
                                ProgressView()
                                    .tint(.white)
                            }

                            Text(authVm.selection == .login ? "Connexion" : "Créer mon compte")
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundStyle(.white)
                        .cornerRadius(12)
                    }
                    .disabled(authVm.isLoading)
                    .padding(.top, 12)

                    // MARK: - Switch Mode
                    Button {
                        withAnimation {
                            authVm.selection = authVm.selection == .login ? .register : .login
                        }
                    } label: {
                        Text(authVm.selection == .login
                             ? "Créer un compte"
                             : "Déjà un compte ? Se connecter")
                        .font(.footnote)
                        .foregroundStyle(.blue)
                    }
                }
                .padding(.horizontal)
            }
            .padding(.top, 40)
        }
        .background(Color.customWhite.ignoresSafeArea())
        .alert(isPresented: $authVm.showError) {
            Alert(
                title: Text("Erreur"),
                message: Text(authVm.error.errorDescription ?? "Une erreur inconnue est survenue"),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

#Preview {
    AuthenticationView()
}
