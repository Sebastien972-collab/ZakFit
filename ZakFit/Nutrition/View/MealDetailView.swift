//
//  MealDetailView.swift
//  ZakFit
//
//  Created by Sébastien Daguin on 05/12/2025.
//


import SwiftUI

struct MealDetailView: View {
    @State private var viewModel: MealDetailViewModel
    
    init(meal: MealResponse) {
        _viewModel = State(initialValue: MealDetailViewModel(meal: meal))
    }
    
    var body: some View {
        @Bindable var vm = viewModel
        
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                
                // MARK: - Header repas
                VStack(alignment: .leading, spacing: 8) {
                    Text(vm.meal.type) // adapte selon ton modèle
                        .font(.title2.bold())
                    
                    Text(vm.meal.date, style: .date)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(Color(.secondarySystemBackground))
                )
                
                // MARK: - Résumé nutritionnel
                VStack(alignment: .leading, spacing: 12) {
                    Text("Résumé nutritionnel")
                        .font(.headline)
                    
                    HStack(spacing: 16) {
                        macroTile(title: "Calories", value: vm.totalCalories, unit: "kcal")
                        macroTile(title: "Protéines", value: vm.totalProtein, unit: "g")
                        macroTile(title: "Glucides", value: vm.totalCarbs, unit: "g")
                        macroTile(title: "Lipides", value: vm.totalFat, unit: "g")
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(Color(.secondarySystemBackground))
                )
                
                // MARK: - Détails des aliments
                VStack(alignment: .leading, spacing: 12) {
                    Text("Aliments du repas")
                        .font(.headline)
                    
                    if vm.isLoading {
                        ProgressView("Chargement des aliments…")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.vertical, 16)
                    } else if let error = vm.errorMessage {
                        Text("Erreur : \(error)")
                            .foregroundStyle(.red)
                            .font(.subheadline)
                    } else if vm.items.isEmpty {
                        Text("Aucun aliment enregistré pour ce repas.")
                            .foregroundStyle(.secondary)
                            .font(.subheadline)
                    } else {
                        ForEach(vm.items) { item in
                            mealItemRow(item)
                                .padding(.vertical, 6)
                                .padding(.horizontal, 10)
                                .background(
                                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                                        .fill(Color(.tertiarySystemBackground))
                                )
                        }
                    }
                }
                
                Spacer(minLength: 24)
            }
            .padding()
        }
        .background(Color.zackFitBackground.ignoresSafeArea())
        .navigationTitle("Détail du repas")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await vm.loadItems()
        }
    }
    
    // MARK: - Subviews
    
    private func macroTile(title: String, value: Double, unit: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
            Text("\(Int(value.rounded())) \(unit)")
                .font(.headline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func mealItemRow(_ item: MealItemResponse) -> some View {
        HStack(alignment: .top, spacing: 12) {
            // Placeholder icône (tu peux changer selon la catégorie plus tard)
            Circle()
                .fill(Color.green.opacity(0.2))
                .frame(width: 36, height: 36)
                .overlay(
                    Image(systemName: "leaf.fill")
                        .foregroundStyle(.green)
                )
            
            VStack(alignment: .leading, spacing: 4) {
                // Pour l’instant on n’a pas le nom de l’aliment, donc on affiche générique
                // Tu pourras enrichir le DTO plus tard avec foodName.
                Text("Aliment")
                    .font(.subheadline.bold())
                
                Text("\(item.quantity.clean) \(item.unit)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                HStack(spacing: 8) {
                    macroBadge(systemName: "flame.fill", text: "\(Int(item.calories.rounded())) kcal")
                    macroBadge(systemName: "circle.fill", text: "\(Int(item.protein.rounded())) g prot.")
                    macroBadge(systemName: "circle.lefthalf.fill", text: "\(Int(item.carbs.rounded())) g gluc.")
                    macroBadge(systemName: "circle.righthalf.fill", text: "\(Int(item.fat.rounded())) g lip.")
                }
                .font(.caption2)
            }
            
            Spacer()
        }
    }
    
    private func macroBadge(systemName: String, text: String) -> some View {
        HStack(spacing: 4) {
            Image(systemName: systemName)
            Text(text)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(Color(.systemBackground).opacity(0.8))
        .clipShape(Capsule())
        .foregroundStyle(.secondary)
    }
}

// Petit helper pour un affichage propre des doubles
private extension Double {
    var clean: String {
        let intVal = Int(self)
        if Double(intVal) == self {
            return "\(intVal)"
        } else {
            return String(format: "%.1f", self)
        }
    }
}
