//
//  AddFoodView.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 25/11/2025.
//

import SwiftUI

struct AddFoodView: View {
    @Environment(AddMealViewModel.self) private var viewModel: AddMealViewModel
    
    @State private var foodVM = FoodItemViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    searchBar
                    categoryChips
                    VStack(spacing: 12) {
                        ForEach(foodVM.filteredFoods) { food in
                            FoodRowView(food: food)
                        }
                    }
                    .padding(.top, 8)
                    
                    addCustomFoodButton
                        .padding(.top, 24)
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .padding(.bottom, 32)
            }
            .navigationTitle("Ajouter un aliment")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                await foodVM.fetchFoods()
            }
        }
        .task {
            await foodVM.fetchFoods()
        }
    }
}

// MARK: - Subviews

private extension AddFoodView {
    
    var searchBar: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)
            
            TextField("Rechercher un aliment...", text: $foodVM.searchText)
                .textInputAutocapitalization(.never)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemGray6))
        )
    }
    
    var categoryChips: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(FoodCategory.allCases) { category in
                    let isSelected = category == foodVM.selectedCategory
                    
                    Button {
                        foodVM.selectedCategory = category
                    } label: {
                        Text(category.rawValue)
                            .font(.subheadline)
                            .fontWeight(isSelected ? .semibold : .regular)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                            .background(
                                Capsule()
                                    .fill(isSelected
                                          ? Color.accentColor
                                          : Color(.systemGray6))
                            )
                            .foregroundStyle(isSelected ? .white : .primary)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.vertical, 4)
        }
    }
    
    var addCustomFoodButton: some View {
        Button {
            // TODO: ouvrir la vue “Ajouter un aliment personnalisé”
        } label: {
            HStack(spacing: 8) {
                Image(systemName: "plus")
                Text("Ajouter un aliment personnalisé")
            }
            .font(.subheadline)
            .foregroundStyle(.secondary)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(style: StrokeStyle(lineWidth: 1,
                                                     dash: [6, 4]))
                    .foregroundStyle(Color(.systemGray3))
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    AddFoodView()
        .environment(AddMealViewModel())
}
