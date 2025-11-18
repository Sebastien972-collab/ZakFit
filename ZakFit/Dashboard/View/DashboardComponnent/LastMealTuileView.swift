//
//  LastMealTuileView.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 18/11/2025.
//

import SwiftUI

struct LastMealTuileView: View {
    let meal: Meal
    var body: some View {
        TuileCardView {
            HStack {
                ImageAndCircleView(sfSymbol: "sun.max.fill", color: Color(meal.type.coulorName))
                VStack(alignment: .leading) {
                    HStack {
                        Text(meal.type.rawValue)
                            .font(.title3)
                            .bold()
                        Spacer()
                        Text(meal.totalCalories.description + "cal")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                    }
                    HStack {
                        Text(meal.name)
                            .foregroundStyle(.secondary)
                            .fontWeight(.semibold)
                        Spacer()
                        Text(meal.date.hourMinuteFormatted())
                            .foregroundStyle(.secondary)
                            .fontWeight(.semibold)
                    }
                }
            }
        }
    }
}

#Preview {
    LastMealTuileView(meal: .carbonara)
}
