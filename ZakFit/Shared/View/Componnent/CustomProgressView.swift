//
//  CustomProgressView.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 18/11/2025.
//

import SwiftUI

struct CustomProgressView: View {
    let title: String
    let progress: Double
    let maxProgress: Double
    var color: Color = .green
    var subtitle: String? = nil
    var showPercentage: Bool = false

    /// Retourne le pourcentage de progression borné entre 0 et 1
    var clampedProgressRatio: Double {
        guard maxProgress > 0 else { return 0 }
        return min(max(progress / maxProgress, 0), 1)
    }
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                Spacer()
                Text(showPercentage ? percentage().description + "%" : "\(progress.description) / \(maxProgress.description)")
                    .foregroundStyle(showPercentage ? .black : .secondary)
            }
            ProgressView(value: clampedProgressRatio)
                .progressViewStyle(.linear)
                .tint(color)
                .controlSize(.large)
            if let subtitle {
                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }
    /// Retourne le pourcentage de progression (0 à 100)
    func percentage() -> Int {
        Int((clampedProgressRatio * 100).rounded())
    }
    
}

#Preview {
    VStack {
        TuileCardView {
            CustomProgressView(title: "Calories", progress: 1247, maxProgress: 2000)
        }
        TuileCardView {
            CustomProgressView(title: "Calories", progress: 1247, maxProgress: 2000,subtitle: "753 calories restantes")
        }
    }
    .padding()
}

