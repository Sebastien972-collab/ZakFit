//
//  HealthPermissionsDetailView.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 18/11/2025.
//


import SwiftUI
import HealthKit

struct HealthPermissionsDetailView: View {
    var body: some View {
        List {
            Section("Données lues depuis Apple Santé") {
                PermissionRow(
                    title: "Énergie active",
                    icon: "flame",
                    color: .orange
                )
                PermissionRow(
                    title: "Pas",
                    icon: "figure.walk",
                    color: .blue
                )
                PermissionRow(
                    title: "Fréquence cardiaque",
                    icon: "heart.fill",
                    color: .red
                )
                PermissionRow(
                    title: "Calories alimentaires",
                    icon: "fork.knife",
                    color: .green
                )
            }
            
            Section("Gestion des autorisations") {
                Text("Vous pouvez modifier les autorisations de l’application depuis l’app Santé.")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .padding(.vertical, 4)
            }
        }
        .navigationTitle("Données Santé")
    }
}

struct PermissionRow: View {
    let title: String
    let icon: String
    let color: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundStyle(color)
            Text(title)
        }
    }
}

#Preview {
    HealthPermissionsDetailView()
}
