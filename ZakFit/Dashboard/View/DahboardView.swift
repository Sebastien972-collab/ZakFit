//
//  DahboardView.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 17/11/2025.
//

import SwiftUI

struct DasboardView: View {
    var body: some View {
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
                DashboardInfoCardView()
                    .offset(y: -25)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.horizontal)
                
                // MARK: ACTIONS RAPIDES — VERSION GRID
                VStack(alignment: .leading, spacing: 12) {
                    Text("Actions Rapide")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                    
                    Grid(alignment: .center, horizontalSpacing: 15, verticalSpacing: 15) {
                        GridRow {
                            QuickActionButton(sfSymbol: "fork.knife",
                                              title: "Ajouter un repas",
                                              color: .green,
                                              action: {})
                            
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
                    .frame(maxWidth: .infinity)
                }
                Spacer()
            }
        }
    }
}

#Preview {
    NavigationStack {
        DasboardView()
    }
}
