//
//  AddMealView.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 18/11/2025.
//


import SwiftUI

struct AddMealView: View {
    @State private var viewModel = AddMealViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                // MARK: Infos repas
                Section("Informations du repas") {
                    TextField("Nom du repas", text: $viewModel.mealName)
                    
                    DatePicker(
                        "Date",
                        selection: $viewModel.date,
                        displayedComponents: [.date, .hourAndMinute]
                    )
                    
                    Picker("Type", selection: $viewModel.type) {
                        ForEach(TypeOfMeal.allCases, id: \.self) { meal in
                            Text(meal.rawValue).tag(meal)
                        }
                    }
                }

                // MARK: Aliments enregistrés
                Section("Aliments enregistrés") {
                    if viewModel.foods.isEmpty {
                        Text("Aucun aliment enregistré")
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach(viewModel.savedFoods) { item in
                            HStack {
                                Text(item.name)
                                Spacer()
                                Text("\(item.calories) kcal")
                                    .foregroundStyle(.secondary)
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation(.easeInOut) {
                                    viewModel.addFood()
                                }
                            }
                        }
                    }
                }
                
                // MARK: Ajout manuel
                Section("Ajouter un aliment") {
                    TextField("Nom de l’aliment", text: $viewModel.tempName)
                    
                    TextField("Calories", value: $viewModel.tempCalories, format: .number)
                        .keyboardType(.numberPad)
                    
                    Button("Ajouter") {
                        viewModel.addFood()
                    }
                    .disabled(viewModel.tempName.isEmpty || viewModel.tempCalories == nil)
                }

                // MARK: Aliments ajoutés au repas
                if !viewModel.foods.isEmpty {
                    Section("Aliments ajoutés") {
                        ForEach(viewModel.foods) { food in
                            HStack {
                                Text(food.name)
                                Spacer()
                                Text("\(food.calories) kcal")
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Ajouter un repas")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Valider") {
                        let meal = viewModel.saveMeal()
                        print("Meal created:", meal)
                        dismiss()
                    }
                    .disabled(viewModel.foods.isEmpty)
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Annuler") { dismiss() }
                }
            }
        }
    }
}
