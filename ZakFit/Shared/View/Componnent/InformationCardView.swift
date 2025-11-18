//
//  InformationCardView.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 17/11/2025.
//

import SwiftUI

struct InformationCardView<Content: View>: View {
    private let content: Content
    private var title: String?
    init(title: String? = nil, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if let title = title {
                Text(title)
                    .font(.title3)
                    .fontWeight(.semibold)
            }
            HStack(alignment: .center, spacing: 0) {
                content
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, maxHeight: 320)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.1), radius: 7.5, x: 0, y: 10)
        .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 4)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(red: 0.9, green: 0.91, blue: 0.92), lineWidth: 0)
        )
    }
}

#Preview {
    InformationCardView() {
        HStack {
            Text("Hydratation : 1,5 L")
            Text("Calories : 1820 kcal")
            Text("Entraînement : Musculation – 45 min")
        }
    }
    .padding()
    InformationCardView(title: "Résumé de la journée", content: {
        Text("Hydratation : 1,5 L")
        Text("Calories : 1820 kcal")
        Text("Entraînement : Musculation – 45 min")
    })
    .padding()
}
