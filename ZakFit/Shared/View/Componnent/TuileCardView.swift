//
//  TuileCardView.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 17/11/2025.
//

import SwiftUI

struct TuileCardView<Content: View>: View {
    private let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            content
        }
        .padding(16)
        .frame(maxWidth: .infinity, maxHeight: 136)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.05), radius: 1, x: 0, y: 1)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .inset(by: 0.5)
                .stroke(
                    Color(red: 0.95, green: 0.96, blue: 0.96),
                    lineWidth: 1
                )
        )
    }
}

#Preview {
    TuileCardView() {
        HStack {
            Text("Hydratation : 1,5 L")
            Text("Calories : 1820 kcal")
            Text("Entraînement : Musculation – 45 min")
        }
    }
    .padding()
}
