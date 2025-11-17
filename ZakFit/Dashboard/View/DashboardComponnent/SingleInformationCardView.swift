//
//  InformationCadView.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 17/11/2025.
//

import SwiftUI

struct SingleInformationCardView: View {
    let sfSymbol: String
    let title: String
    let subtitle: String
    var color: Color = .blue
    var body: some View {
        VStack(spacing: 8) {
            ImageAndCircleView(sfSymbol: sfSymbol, color: color)
            Text(title)
                .font(.system(size: 18, weight: .bold))
                .multilineTextAlignment(.center)
            Text(subtitle)
                .font(.system(size: 14, weight: .light))
                .multilineTextAlignment(.center)
        }
        
    }
}

#Preview {
    SingleInformationCardView(sfSymbol: "flame.fill", title: "1,247", subtitle: "Calories", color: .green)
}

struct ImageAndCircleView: View {
    let sfSymbol: String
    var color: Color = .blue
    var body: some View {
        ZStack {
            Circle()
                .fill(color.opacity(0.3))
                .frame(width: 48, height: 48)
            Image(systemName: sfSymbol)
                .resizable()
                .scaledToFill()
                .frame(width: 16, height: 16)
                .padding()
                .foregroundStyle(color)
        }
    }
}
