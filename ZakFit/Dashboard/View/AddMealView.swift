//
//  AddMealView.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 18/11/2025.
//


import SwiftUI

struct AddMealView: View {
    @Environment(AddMealViewModel.self) private var viewModel: AddMealViewModel
    @State private var showingAddFood = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    MealInfoCardView()
                    AddedFoodsCardView()
                    AddFoodButtonView(showingAddFood: $showingAddFood)
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .padding(.bottom, 32)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Ajouter un repas")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Valider") {
                        Task {
                            await viewModel.saveMeal()
                        }
                        print("Meal created:")
                        dismiss()
                    }
                    .disabled(viewModel.foods.isEmpty)
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Annuler") { dismiss() }
                }
            }
            .sheet(isPresented: $showingAddFood) {
                NavigationStack {
                    AddFoodView()
                        .navigationTitle("Ajouter un aliment")
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Fermer") {
                                    showingAddFood = false
                                }
                            }
                        }
                }
            }
        }
    }
}

// MARK: - MealInfoCardView

struct MealInfoCardView: View {
    @Environment(AddMealViewModel.self) private var viewModel: AddMealViewModel
    
    var body: some View {
        @Bindable var viewModel = viewModel
        VStack(alignment: .leading, spacing: 16) {
            Text("Informations du repas")
                .font(.headline)
            
            VStack(alignment: .leading, spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Date")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    DatePicker(
                        "",
                        selection: $viewModel.date,
                        displayedComponents: [.date, .hourAndMinute]
                    )
                    .labelsHidden()
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Type de repas")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    Picker("", selection: $viewModel.type) {
                        ForEach(TypeOfMeal.allCases, id: \.self) { meal in
                            Text(meal.rawValue).tag(meal)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.secondarySystemBackground))
                .shadow(color: Color.black.opacity(0.04),
                        radius: 8, x: 0, y: 4)
        )
    }
}

// MARK: - AddedFoodsCardView

struct AddedFoodsCardView: View {
    @Environment(AddMealViewModel.self) private var viewModel: AddMealViewModel
    
    var body: some View {
        let totalCalories = viewModel.foods.reduce(0.0) { partial, food in
            partial + food.caloriesPer100g
        }
        
        return VStack(alignment: .leading, spacing: 12) {
            Text("Aliments ajoutés")
                .font(.headline)
            
            if viewModel.foods.isEmpty {
                Text("Aucun aliment pour l’instant.\nAjoute ton premier aliment pour commencer.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            } else {
                ForEach(viewModel.foods) { food in
                    HStack {
                        Text(food.name)
                        Spacer()
                        Text("\(Int(food.caloriesPer100g)) kcal")
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 4)
                }
                
                Divider()
                
                HStack {
                    Text("Total")
                        .fontWeight(.semibold)
                    Spacer()
                    Text("\(Int(totalCalories)) kcal")
                        .fontWeight(.semibold)
                }
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.secondarySystemBackground))
                .shadow(color: Color.black.opacity(0.04),
                        radius: 8, x: 0, y: 4)
        )
    }
}

// MARK: - AddFoodButtonView

struct AddFoodButtonView: View {
    @Binding var showingAddFood: Bool
    
    var body: some View {
        Button {
            showingAddFood = true
        } label: {
            HStack(spacing: 8) {
                Image(systemName: "plus.circle.fill")
                    .font(.title3)
                VStack(alignment: .leading, spacing: 2) {
                    Text("Ajouter un aliment")
                        .font(.headline)
                    Text("Choisir dans la base d’aliments ou en créer un personnalisé.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                Spacer()
            }
            .padding(16)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.systemGray6))
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    NavigationStack {
        AddMealView()
    }
    .environment(AddMealViewModel())
}
