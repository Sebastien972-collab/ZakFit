//
//  GoalSelectionView.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 18/11/2025.
//


import SwiftUI

struct GoalSelectionView: View {
    @State private var viewModel = GoalSelectionViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Choisis ton objectif") {
                    ForEach(UserGoal.allCases, id: \.self) { goal in
                        HStack {
                            Text(goal.rawValue)
                            Spacer()
                            if viewModel.selectedGoal == goal {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                viewModel.selectedGoal = goal
                            }
                        }
                    }
                }
            }
            .navigationTitle("Objectif")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Valider") {
                        viewModel.saveGoal()
                        dismiss()
                    }
                    .disabled(viewModel.selectedGoal == nil)
                }
            }
        }
    }
}

#Preview {
    GoalSelectionView()
}
