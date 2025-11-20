//
//  ContentView.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 17/11/2025.
//

import SwiftUI

struct MainTabView: View {
    @Environment(TabViewModel.self) private var tabVm: TabViewModel
    var body: some View {
        @Bindable var tabVm = tabVm
        Group(content: {
            switch tabVm.authState {
            case .loading:
                ProgressView("Chargement...")
                    .task {
                        await tabVm.checkSession()
                    }
            case .authenticated:
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
            case .notAuthenticated:
                AuthenticationView()
            case .firstLaunch:
               Text("Bienvenue dans l'application")
                
            }
        })
        .alert("Erreur", isPresented: $tabVm.showError) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(tabVm.error?.localizedDescription ?? "Une erreur est survenue.")
        }
        .animation(.easeInOut, value: tabVm.authState)
        
    }
}

#Preview {
    MainTabView()
        .environment(TabViewModel())
}
