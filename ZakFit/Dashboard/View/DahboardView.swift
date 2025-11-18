//
//  DahboardView.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 17/11/2025.
//

import SwiftUI

struct DasboardView: View {
    @State private var dashboardVm: DashboardViewModel = .init()
    @State private var showAddMealView: Bool = false
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // MARK: HEADER
                    ZStack {
                        SunsetGradientView()
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .ignoresSafeArea(.all)
                        
                        HeaderView(
                            selection: .urlImage(url: URL(string: "https://images.pexels.com/photos/2057435/pexels-photo-2057435.jpeg")!),
                            title: "Bonjour, Sébastien",
                            subtitle: "Continuons votre parcours santé"
                        )
                    }
                    
                    // MARK: INFORMATION CARD
                    InfoCardView()
                        .offset(y: -25)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.horizontal)
                    
                    // MARK: ACTIONS RAPIDES — VERSION GRID
                    DashboardSectionView(title: "Actions Rapide") {
                        Grid(alignment: .center, horizontalSpacing: 15, verticalSpacing: 15) {
                            GridRow {
                                QuickActionButton(sfSymbol: "fork.knife",
                                                  title: "Ajouter un repas",
                                                  color: .green,
                                                  action: {
                                    showAddMealView.toggle()
                                })
                                .sheet(isPresented: $showAddMealView) {
                                    AddMealView()
                                    .presentationDetents([.medium, .large])
                                    .presentationDragIndicator(.hidden)
                                }
                                
                                
                                QuickActionButton(sfSymbol: "figure.run",
                                                  title: "Entraînement",
                                                  color: .suggestionPurple,
                                                  action: {})
                            }
                            
                            GridRow {
                                QuickActionButton(sfSymbol: "figure.stand.line.dotted.figure.stand",
                                                  title: "Poids",
                                                  color: .orange,
                                                  action: {})
                                
                                QuickActionButton(sfSymbol: "chart.line.uptrend.xyaxis",
                                                  title: "Progrès",
                                                  color: .blue,
                                                  action: {})
                            }
                        }
                    }
                    .padding(.horizontal)
                    DashboardSectionView(title: "Aujourd'hui") {
                        TuileCardView {
                            CustomProgressView(title: "Calories", progress: 1247, maxProgress: 2000, subtitle: "\(2000 - 1247) calories restantes")
                        }
                        HydratationView(litre: 1.25)
                    }
                    if dashboardVm.lastMeal.isEmpty == false {
                        DashboardSectionView(title: "Repas récent") {
                        } content: {
                            ForEach(dashboardVm.lastMeal) { meal in
                                LastMealTuileView(meal: meal)
                            }
                        }
                    }
                    
                    Spacer()
                }
            }
            .background {
                Color.zackFitBackground.ignoresSafeArea(.all)
            }
        }
    }
}

#Preview {
    NavigationStack {
        DasboardView()
    }
}
