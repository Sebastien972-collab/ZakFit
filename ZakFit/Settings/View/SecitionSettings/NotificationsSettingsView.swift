//
//  NotificationsSettingsView.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 18/11/2025.
//


import SwiftUI

struct NotificationsSettingsView: View {
    @State private var remindersEnabled = true
    @State private var mealReminders = false
    @State private var trainingReminders = false
    @State private var hydrationReminders = false
    
    var body: some View {
        Form {
            Section("Général") {
                Toggle("Activer les rappels", isOn: $remindersEnabled)
            }
            
            if remindersEnabled {
                Section("Rappels") {
                    Toggle("Repas", isOn: $mealReminders)
                    Toggle("Entraînements", isOn: $trainingReminders)
                    Toggle("Hydratation", isOn: $hydrationReminders)
                }
            }
            
            Section {
                Text("Les notifications peuvent être ajustées dans les réglages système.")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
        .navigationTitle("Notifications")
    }
}

#Preview {
    NotificationsSettingsView()
}
