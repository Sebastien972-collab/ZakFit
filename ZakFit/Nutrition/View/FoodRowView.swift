//
//  FoodRowView.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 02/12/2025.
//

import SwiftUI

struct FoodRowView: View {
    @Environment(AddMealViewModel.self) private var viewModel: AddMealViewModel
    let food: FoodItem
    
    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(Color(.systemGray6))
                Image(systemName: FoodCategory(rawValue: food.category)?.sfSymbolName ?? "leaf")
                    .font(.title3)
            }
            .frame(width: 44, height: 44)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(food.name)
                    .font(.body)
                    .fontWeight(.semibold)
                
                Text("\(food.caloriesPer100g.formatted()) kcal / 100g")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            HStack {
                if viewModel.containsFood(named: food.name) {
                    Button {
                        withAnimation {
                            viewModel.remove(food: food)
                        }
                    } label: {
                        Image(systemName: "minus.circle")
                            .font(.subheadline)
                            .foregroundStyle(.tertiary)
                    }
                    Text(viewModel.foods.filter { $0.id == food.id}.count.description)
                }
                Button {
                    withAnimation {
                        viewModel.addFood(food: food)
                    }
                } label: {
                    Image(systemName: "plus.circle")
                        .font(.subheadline)
                        .foregroundStyle(.tertiary)
                }
            }
            

        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.04),
                        radius: 8, x: 0, y: 4)
        )
    }
}

#Preview {
    FoodRowView(food: FoodItem(id: .init(), name: "Banane", category: "Fruit", caloriesPer100g: 0.3, proteinPer100g: 1.1, carbsPer100g: 23, fatPer100g: 89))
        .environment(AddMealViewModel())
}
