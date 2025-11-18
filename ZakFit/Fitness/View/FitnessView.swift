//
//  FitnessView.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 18/11/2025.
//

import SwiftUI

struct FitnessView: View {
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    ZStack {
                        Color.customPurple
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .ignoresSafeArea(.all)
                        HeaderView(selection: .sfImage(systemName: "dumbbell.fill"), title: "Votre Coach Fitness", subtitle: "Analysons votre activité physique")
                    }
                    InformationCardView(title: "Résumé du jour", content: {
                        VStack(spacing: 16) {
                            HStack() {
                                SingleInformationCardView(sfSymbol: "shoeprints.fill", title: "6,247", subtitle: "/ 10,000 pas", color: .suggestionPurple)
                                Spacer()
                                SingleInformationCardView(sfSymbol: "flame.fill", title: "347", subtitle: "calories brûlées", color: .orange)
                                Spacer()
                                SingleInformationCardView(sfSymbol: "leaf.fill", title: "28", subtitle: "min actives", color: .customGreen)
                            }
                            CustomProgressView(title: "Objectif de pas", progress: 0.62, maxProgress: 1, showPercentage: true)
                            CustomProgressView(title: "Minutes actives", progress: 0.56, maxProgress: 1, color: .customLightBlue, showPercentage: true)
                            CustomProgressView(title: "Calories brûlées", progress: 0.69, maxProgress: 1, color: .customGreen, showPercentage: true)
                        }
                    })
                    .offset(y: -16)
                    .padding(.horizontal)
                    
                    DashboardSectionView(title: "Cette semaine") {
                        WeekActivityView()
                            .padding(.horizontal)
                    }
                }
                
            }
        }
    }
}

#Preview {
    FitnessView()
}
