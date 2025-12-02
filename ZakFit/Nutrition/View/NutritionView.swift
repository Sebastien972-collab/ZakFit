//
//  NutritionView.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 18/11/2025.
//

import SwiftUI

struct NutritionView: View {
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    ZStack {
                        Color.customPurple
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .ignoresSafeArea(.all)
                        HeaderView(selection: .sfImage(systemName: "fork.knife.circle"), title: "Votre Coach Nutritionnel", subtitle: "Analysons votre journée alimentaire")
                    }
                    InformationCardView(title: "Résumé du jour", content: {
                        VStack(spacing: 16) {
                            HStack() {
                                SingleInformationCardView(sfSymbol: "flame.fill", title: "1,247", subtitle: "/ 2,000 cal", color: .green)
                                Spacer()
                                SingleInformationCardView(sfSymbol: "dumbbell.fill", title: "68g", subtitle: "/ 150g protéines", color: .customLightBlue)
                                Spacer()
                                SingleInformationCardView(sfSymbol: "leaf.fill", title: "12g", subtitle: "/ 25g fibres", color: .customGreen)
                            }
                            CustomProgressView(title: "Calories", progress: 0.67, maxProgress: 1, showPercentage: true)
                            CustomProgressView(title: "Protéines", progress: 0.45, maxProgress: 1, color: .customLightBlue, showPercentage: true)
                            CustomProgressView(title: "Calories", progress: 0.48, maxProgress: 1, color: .customGreen, showPercentage: true)
                            
                        }
                    })
                    .offset(y: -16)
                    .padding(.horizontal)
                }
                
            }
        }
    }
}

#Preview {
    NutritionView()
        .environment(AddMealViewModel())
}
