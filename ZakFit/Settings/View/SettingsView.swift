//
//  SettingsView 2.swift
//  ZakFit
//
//  Created by Sébastien Daguin on 18/11/2025.
//

import SwiftUI

struct SettingsView: View {
    @State private var viewModel = SettingsViewModel()
    private var currentUser: User {
        UserManager.shared.currentUser
    }
    var body: some View {
        @Bindable var viewModel = viewModel
        NavigationStack {
            ScrollView {
                VStack(spacing: 32) {
                    // MARK: - Profil & Compte
                    settingsSection(title: "Profil & Compte") {
                        NavigationLink {
                            UserBasicInfoFormView()
                        } label: {
                            HStack(spacing: 16) {
                                Circle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(width: 52, height: 52)
                                    .overlay(
                                        Image(systemName: "person.fill")
                                            .font(.title2)
                                            .foregroundStyle(.gray)
                                    )
                                
                                VStack(alignment: .leading) {
                                    Text(currentUser.firstName + " " + currentUser.lastName)
                                        .font(.headline)
                                    Text(currentUser.email)
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                    Text("\(currentUser.currentWeightKg) kg • \(currentUser.heightCm) cm")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.secondary)
                            }
                            .padding(.vertical, 4)
                        }
                        Button {
                            viewModel.logout()
                        } label: {
                            Text("Se déconnecter")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.red.opacity(0.9))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        .padding(.top, 12)
                    }
                    // MARK: - Santé & Données
                    settingsSection(title: "Santé & Données") {
                        // Lien vers le détail HealthKit
                        NavigationLink {
                            HealthPermissionsDetailView()
                        } label: {
                            settingRow(
                                icon: "heart.fill",
                                iconColor: .pink,
                                title: "HealthKit",
                                subtitle: "Synchronisation avec Santé",
                                trailing: AnyView(
                                    Text(viewModel.healthAuthorized ? "Activé" : "Inactif")
                                        .foregroundStyle(viewModel.healthAuthorized ? .green : .secondary)
                                )
                            )
                        }
                        
                        Button {
                            viewModel.requestHealthAuthorization()
                        } label: {
                            Text(viewModel.healthAuthorized ? "Mettre à jour les permissions" : "Activer l’accès Santé")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .padding(.top, 6)
                        }
                        
                        // Autres permissions détaillées
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Autorisations de données")
                                .font(.headline)
                                .foregroundStyle(.secondary)
                            
                            permissionToggle("Pas & Distance", icon: "figure.walk", binding: $viewModel.stepsEnabled)
                            permissionToggle("Énergie active", icon: "bolt.fill", binding: $viewModel.energyEnabled)
                            permissionToggle("Minutes d'exercice", icon: "clock.fill", binding: $viewModel.exerciseEnabled)
                            permissionToggle("Fréquence cardiaque", icon: "heart.circle.fill", binding: $viewModel.heartRateEnabled)
                            permissionToggle("Sommeil", icon: "bed.double.fill", binding: $viewModel.sleepEnabled)
                            permissionToggle("Poids & IMC", icon: "scalemass.fill", binding: $viewModel.weightEnabled)
                        }
                        .padding(.top, 8)
                    }
                    // MARK: - Notifications
                    settingsSection(title: "Notifications") {
                        toggleRow("Notifications push", icon: "bell.badge.fill", binding: $viewModel.notificationsEnabled)
                        if viewModel.notificationsEnabled {
                            NavigationLink {
                                NotificationsSettingsView()
                            } label: {
                                settingRow(icon: "slider.horizontal.3",
                                           iconColor: .purple,
                                           title: "Préférences",
                                           subtitle: "Rappels & coaching")
                            }
                        }
                    }
                    
                    
                    // MARK: - Paramètres généraux
                    settingsSection(title: "Paramètres généraux") {
                        NavigationLink {
                            AppearanceSettingsView()
                        } label: {
                            settingRow(icon: "wand.and.stars",
                                       iconColor: .orange,
                                       title: "Apparence")
                        }
                        
                        toggleRow("Animations visuelles", icon: "sparkles", binding: $viewModel.animationsEnabled)
                    }
                    
                    // MARK: - Confidentialité
                    settingsSection(title: "Confidentialité & Sécurité") {
                        
                        HStack {
                            Image(systemName: "checkmark.shield.fill")
                                .foregroundStyle(.green)
                            Text("ZakFit respecte votre confidentialité.")
                                .font(.subheadline)
                        }
                        .padding(.bottom, 8)
                        
                        NavigationLink("Politique de confidentialité") {
                            PrivacyPolicyView()
                        }
                        NavigationLink("Conditions d’utilisation") {
                            TermsOfUseView()
                        }
                        
                        Button(role: .destructive) {
                            viewModel.deleteAccount()
                        } label: {
                            Text("Supprimer mon compte")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.red.opacity(0.1))
                                .foregroundStyle(.red)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        .padding(.top, 8)
                    }
                    
                    // MARK: - Footer
                    VStack(spacing: 8) {
                        Image(systemName: "heart.fill")
                            .font(.largeTitle)
                            .foregroundColor(.blue)
                            .padding(8)
                            .background(Color.blue.opacity(0.15))
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                        
                        Text("ZakFit")
                            .font(.title3.bold())
                        
                        Text("Version 1.1.0")
                            .foregroundStyle(.secondary)
                            .font(.subheadline)
                        
                        Text("Développé avec ❤️ pour votre bien-être.")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                            .padding(.top, 4)
                    }
                    .padding(.top, 16)
                    .padding(.bottom, 60)
                }
                .padding()
            }
            .navigationTitle("Réglages")
            .task {
                await viewModel.updateHealthStatus()
            }
        }
    }
    // MARK: - UI HELPERS

    /// Section avec un fond arrondi comme dans le mockup
    @ViewBuilder
    func settingsSection<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.title3.bold())
                .padding(.horizontal, 4)
            
            VStack(spacing: 0) {
                content()
            }
            .padding()
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }

    /// Ligne de réglage standard avec icône + titre + sous-titre + trailing optionnel
    func settingRow(
        icon: String,
        iconColor: Color = .blue,
        title: String,
        subtitle: String? = nil,
        trailing: AnyView? = nil
    ) -> some View {
        
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(iconColor)
                .frame(width: 30)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.body)
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            
            Spacer()
            
            if let trailing = trailing {
                trailing
            } else {
                Image(systemName: "chevron.right")
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 10)
    }

    /// Toggle avec icône comme dans la maquette
    func toggleRow(_ title: String, icon: String, binding: Binding<Bool>) -> some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(.blue)
                .frame(width: 30)
            
            Toggle(title, isOn: binding)
        }
        .padding(.vertical, 8)
    }

    /// Ligne de permission HealthKit
    func permissionToggle(_ title: String, icon: String, binding: Binding<Bool>) -> some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(.pink)
                .frame(width: 30)
            
            Toggle(title, isOn: binding)
        }
        .padding(.vertical, 6)
    }
}

#Preview {
    SettingsView()
}
