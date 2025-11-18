//
//  PrivacySettingsView.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 18/11/2025.
//


import SwiftUI

struct PrivacySettingsView: View {
    @State private var analyticsEnabled = false
    @State private var personalizedTips = true
    
    var body: some View {
        Form {
            Section("Confidentialité") {
                Toggle("Partage anonymisé pour l'amélioration", isOn: $analyticsEnabled)
                Toggle("Conseils personnalisés", isOn: $personalizedTips)
            }
            
            Section {
                NavigationLink("Voir vos données stockées") {
                    DataOverviewView()
                }
                NavigationLink("Politique de confidentialité") {
                    PrivacyPolicyView()
                }
            }
        }
        .navigationTitle("Confidentialité")
    }
}

struct DataOverviewView: View {
    var body: some View {
        List {
            Text("Historique des repas")
            Text("Historique d’entraînement")
            Text("Données Santé importées")
        }
        .navigationTitle("Vos données")
    }
}
#Preview {
    PrivacySettingsView()
}
