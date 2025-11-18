//
//  HydratationView.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 18/11/2025.
//

import SwiftUI

struct HydratationView: View {
    var litre: Decimal = 0
    var maxLitre: Decimal = 2.5
    
    var body: some View {
        TuileCardView {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "drop.fill")
                        .font(.largeTitle)
                        .foregroundStyle(.customLightBlue)
                    Text("Hydratation")
                        .font(.title3)
                        .bold()
                    Spacer()
                    Text("\(litre.description)L \(maxLitre.description)L")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                }
                HStack {
                    ForEach(1...5, id: \.self) { level in
                        let isChecked: Bool = level <= hydrationLevel()
                        ZStack() {
                            Circle()
                                .frame(width: 32, height: 32)
                                .foregroundStyle(isChecked ? .customLightBlue : .silver)
                            if isChecked {
                                Image(systemName: "checkmark.circle")
                                    .foregroundStyle(.white)
                                    .frame(width: 10.5, height: 12)
                            }
                        }
                    }
                }
            }
        }
    }
    /// Retourne un entier de 1 à 5 selon le pourcentage de `litre` par rapport à `maxLitre`.
    /// 1 = très faible, 5 = objectif atteint ou dépassé.
    func hydrationLevel() -> Int {
        // Convertit en Double pour le calcul
        let current = (litre as NSDecimalNumber).doubleValue
        let maxValue = (maxLitre as NSDecimalNumber).doubleValue
        guard maxValue > 0 else { return 1 }
        let ratio = Swift.max(0.0, Swift.min(current / maxValue, 1.0))
        let level = Int(ceil(ratio * 5.0))
        return Swift.max(1, Swift.min(level, 5))
    }
}

#Preview {
    HydratationView()
        .padding()
}
