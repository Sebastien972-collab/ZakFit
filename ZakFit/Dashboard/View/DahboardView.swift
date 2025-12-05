//
//  DahboardView.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 17/11/2025.
//

import SwiftUI
import SJDToolbox

struct DasboardView: View {
    @State private var dashboardVm: DashboardViewModel = .init()
    @State private var showAddMealView: Bool = false
    @State private var showAddTrainningView: Bool = false
    private var currentUser: User = UserManager.shared.currentUser
    var body: some View {
        @Bindable var dashboardVm = dashboardVm 
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
                            title: "Bonjour, \(currentUser.firstName)",
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
                                                  action: {
                                    showAddTrainningView.toggle()
                                })
                                .sheet(isPresented: $showAddTrainningView) {
                                    AddTrainingView()
                                        .presentationDetents([.medium, .large])
                                        .presentationDragIndicator(.hidden)
                                }
                            }
                            
//                            GridRow {
//                                QuickActionButton(sfSymbol: "figure.stand.line.dotted.figure.stand",
//                                                  title: "Poids",
//                                                  color: .orange,
//                                                  action: {})
//                                
//                                QuickActionButton(sfSymbol: "chart.line.uptrend.xyaxis",
//                                                  title: "Progrès",
//                                                  color: .blue,
//                                                  action: {})
//                            }
                        }
                    }
                    .padding(.horizontal)
                    DashboardSectionView(title: "Aujourd'hui") {
                        TuileCardView {
                            CustomProgressView(title: "Calories", progress: 1247, maxProgress: 2000, subtitle: "\(2000 - 1247) calories restantes")
                        }
                        HydratationView(litre: 1.25)
                    }
                    DashboardSectionView(title: "Repas récent") {
                        ForEach(dashboardVm.lastMeal) { meal in
                            NavigationLink {
                                MealDetailView(meal: meal)
                            } label: {
                                LastMealTuileView(meal: meal)
                            }

                        }
                        .navigationTitle("Repas")
                    } content: {
                        ForEach(dashboardVm.lastMeal.suffix(3)) { meal in
                            LastMealTuileView(meal: meal)
                        }
                    }
                    DashboardSectionView(title: "Entrainnements récent") {
                        ForEach(dashboardVm.lastActivity) { trainning in
                           LastActivityTuileView(training: trainning)
                        }
                        .navigationTitle("Entrainnements")
                    } content: {
                        ForEach(dashboardVm.lastActivity.suffix(3)) { trainning in
                           LastActivityTuileView(training: trainning)
                        }
                    }
                    Spacer()
                }
            }
            .background {
                Color.zackFitBackground.ignoresSafeArea(.all)
            }
            .task {
                do {
                    try await UserManager.shared.fetchProfil()
                    await dashboardVm.fetchLastMeal()
                    await dashboardVm.fetchLastActivity()
                } catch {
                    print("Error fetching user: \(error.localizedDescription)")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        DasboardView()
    }
}
