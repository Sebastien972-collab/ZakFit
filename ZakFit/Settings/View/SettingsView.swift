//
//  SettingsView 2.swift
//  ZakFit
//
//  Created by Sébastien Daguin on 18/11/2025.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var viewModel = SettingsViewModel()
    
    var body: some View {
        @Bindable var viewModel = viewModel   // <- indispensable
        
        NavigationStack {
            Form {
                // MARK: - Profil
                Section("Profil") {
                    NavigationLink("Informations personnelles") {
                        UserBasicInfoFormView()
                    }
                    NavigationLink("Objectif") {
                        GoalSelectionView()
                    }
                }
                
                // MARK: - Santé
                Section("Santé") {
                    HStack {
                        Text("Apple Santé")
                        Spacer()
                        Text(viewModel.healthAuthorized ? "Activé" : "Désactivé")
                            .foregroundStyle(viewModel.healthAuthorized ? .green : .secondary)
                    }
                    
                    Button {
                        viewModel.requestHealthAuthorization()
                    } label: {
                        Text(viewModel.healthAuthorized
                             ? "Mettre à jour les permissions"
                             : "Activer l’accès Santé")
                    }
                    
                    NavigationLink("Sources et permissions") {
                        HealthPermissionsDetailView()
                    }
                }
                
                // MARK: - Notifications
                Section("Notifications") {
                    Toggle("Activer les notifications", isOn: $viewModel.notificationsEnabled)
                    
                    if viewModel.notificationsEnabled {
                        NavigationLink("Préférences") {
                            NotificationsSettingsView()
                        }
                    }
                }
                
                // MARK: - Apparence
                Section("Apparence") {
                    Toggle("Mode sombre", isOn: $viewModel.darkMode)
                }
                
                // MARK: - Confidentialité
                Section("Confidentialité") {
                    NavigationLink("Données et sécurité") {
                        PrivacySettingsView()
                    }
                    NavigationLink("Exporter mes données") {
                        ExportDataView()
                    }
                    NavigationLink("Supprimer mon compte") {
                        DeleteAccountView()
                    }
                }
                
                // MARK: - À propos
                Section("À propos") {
                    NavigationLink("Conditions d’utilisation") {
                        TermsOfUseView()
                    }
                    
                    NavigationLink("Politique de confidentialité") {
                        PrivacyPolicyView()
                    }
                    
                    NavigationLink("Support") {
                        SupportView()
                    }
                    
                    HStack {
                        Text("Version de l’application")
                        Spacer()
                        Text("1.0.0")
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle("Réglages")
        }
    }
}

#Preview {
    SettingsView()
}
