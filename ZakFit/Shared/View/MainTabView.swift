//
//  ContentView.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 17/11/2025.
//

import SwiftUI

struct MainTabView: View {
    @Environment(TabViewModel.self) private var tabViewModel
    var body: some View {
        TabView {
            Tab("Dashboard", systemImage: "house.fill") {
                DasboardView()
                    .tag(TabViewModel.Selection.home)
            }
            Tab("Nutrition", systemImage: "fork.knife") {
                NutritionView()
                    .tag(TabViewModel.Selection.nutrition)
            }
            Tab("Fitness", systemImage: "figure.run") {
                FitnessView()
                    .tag(TabViewModel.Selection.fitness)
            }
            Tab("Profil", systemImage: "person.crop.circle") {
                ProfilView()
                    .tag(TabViewModel.Selection.home)
            }
        }
        .tabBarMinimizeBehavior(.onScrollDown)
    }
}

#Preview {
    MainTabView()
        .environment(TabViewModel())
}
