//
//  AppearanceSettingsView.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 19/11/2025.
//

import SwiftUI

struct AppearanceSettingsView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State var viewModel: SettingsViewModel = SettingsViewModel()
    
    enum AppTheme: String, CaseIterable {
        case system = "Système"
        case light = "Clair"
        case dark = "Sombre"
    }
    
    @State private var selectedTheme: AppTheme = .system
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 32) {
                    
                    // MARK: - Mode d'affichage
                    themeSection
                    
                    // MARK: - Animations
                    animationSection
                    
                    // MARK: - Aperçu
                    previewSection
                }
                .padding()
            }
            .navigationTitle("Apparence")
        }
    }
    
    // MARK: - Thème Section
    private var themeSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Thème de l'application")
                .font(.title3.bold())
            
            VStack(spacing: 0) {
                themeRow(type: .system)
                divider
                themeRow(type: .light)
                divider
                themeRow(type: .dark)
            }
            .padding()
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
    
    private func themeRow(type: AppTheme) -> some View {
        HStack {
            Image(systemName: icon(for: type))
                .foregroundColor(color(for: type))
                .font(.title3)
                .frame(width: 30)
            
            Text(type.rawValue)
                .font(.body)
            
            Spacer()
            
            if selectedTheme == type {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(.blue)
            }
        }
        .contentShape(Rectangle())
        .padding(.vertical, 10)
        .onTapGesture {
            selectedTheme = type
            applyTheme(type)
        }
    }
    
    private var divider: some View {
        Rectangle()
            .frame(height: 0.6)
            .foregroundStyle(.separator)
            .padding(.horizontal, -8)
    }
    
    private func icon(for theme: AppTheme) -> String {
        switch theme {
        case .system: return "iphone"
        case .light: return "sun.max.fill"
        case .dark: return "moon.fill"
        }
    }
    
    private func color(for theme: AppTheme) -> Color {
        switch theme {
        case .system: return .gray
        case .light: return .yellow
        case .dark: return .purple
        }
    }
    
    private func applyTheme(_ theme: AppTheme) {
        switch theme {
        case .system:
            viewModel.darkMode = false
        case .light:
            viewModel.darkMode = false
        case .dark:
            viewModel.darkMode = true
        }
    }
    
    // MARK: - Animation Section
    private var animationSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Effets visuels")
                .font(.title3.bold())
            
            VStack(spacing: 0) {
                HStack(spacing: 16) {
                    Image(systemName: "sparkles")
                        .font(.title3)
                        .foregroundColor(.blue)
                        .frame(width: 30)
                    
                    Toggle("Animations visuelles", isOn: $viewModel.animationsEnabled)
                }
                .padding(.vertical, 10)
            }
            .padding()
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
    
    // MARK: - Preview Section
    private var previewSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Aperçu")
                .font(.title3.bold())
            
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.secondarySystemBackground))
                .frame(height: 150)
                .overlay(
                    VStack(spacing: 8) {
                        Text("Aperçu du thème")
                            .font(.headline)
                        Text("Vos modifications s’appliquent instantanément.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                )
        }
    }
}

#Preview {
    AppearanceSettingsView()
}
