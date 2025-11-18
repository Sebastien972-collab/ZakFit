//
//  SettingsView.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 18/11/2025.
//


import SwiftUI
import HealthKit

struct SettingsView: View {
    @State private var showGoalSelection = false
    @State private var showHealthKitSheet = false
    @State private var notificationsEnabled = true
    @State private var darkMode = false
    @State private var healthAuthorized = false
    
    var body: some View {
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
                
                // MARK: - Santé / HealthKit
                Section("Santé") {
                    Toggle("Synchroniser avec Apple Santé", isOn: $healthAuthorized)
                        .onChange(of: healthAuthorized) { _, _ in
                            requestHealthKitPermission()
                        }
                    
                    NavigationLink("Sources et permissions") {
                        HealthPermissionsDetailView()
                    }
                }
                
                // MARK: - Notifications
                Section("Notifications") {
                    Toggle("Activer les notifications", isOn: $notificationsEnabled)
                    
                    if notificationsEnabled {
                        NavigationLink("Préférences") {
                            NotificationsSettingsView()
                        }
                    }
                }
                
                // MARK: - Apparence
                Section("Apparence") {
                    Toggle("Mode sombre", isOn: $darkMode)
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

// MARK: - HealthKit
extension SettingsView {
    private func requestHealthKitPermission() {
        let healthStore = HKHealthStore()
        
        let readTypes: Set<HKObjectType> = [
            .quantityType(forIdentifier: .activeEnergyBurned)!,
            .quantityType(forIdentifier: .stepCount)!,
            .quantityType(forIdentifier: .heartRate)!,
            .quantityType(forIdentifier: .dietaryEnergyConsumed)!
        ]
        
        healthStore.requestAuthorization(toShare: [], read: readTypes) { success, _ in
            DispatchQueue.main.async {
                healthAuthorized = success
            }
        }
    }
}

#Preview {
    SettingsView()
}
