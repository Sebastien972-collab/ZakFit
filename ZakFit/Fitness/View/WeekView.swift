//
//  WeekView.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 18/11/2025.
//

import SwiftUI

struct WeekActivityView: View {
    private let days = ["L", "M", "M", "J", "V", "S", "D"]
    // Exemple : 0 = inactif, 1 = actif, 2 = en attente/todo
    private let status: [Int] = [1, 0, 1, 1, 0, 2, 0]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 18) {
                ForEach(days.indices, id: \.self) { index in
                    DayCircle(
                        letter: days[index],
                        state: status[index]
                    )
                }
            }
            
            HStack {
                Text("3 jours actifs")
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Text("Objectif : 5 jours")
                    .foregroundColor(Color("customPurple"))
                    .fontWeight(.semibold)
            }
            .font(.subheadline)
        }
        .padding()
    }
}

struct DayCircle: View {
    let letter: String
    let state: Int
    
    var body: some View {
        VStack(spacing: 6) {
            Text(letter)
                .font(.caption)
                .foregroundColor(state == 2 ? Color("customPurple") : .secondary)
            
            ZStack {
                circleBackground
                
                innerSymbol
            }
            .frame(width: 30, height: 30)
        }
    }
    
    @ViewBuilder
    private var circleBackground: some View {
        switch state {
        case 1: // actif = vert clair
            Circle()
                .fill(Color.green.opacity(0.25))
        case 0: // jour inactif = gris clair
            Circle()
                .fill(Color.gray.opacity(0.1))
        case 2: // jour sélectionné / pending = cercle violet bordure
            Circle()
                .stroke(Color("customPurple"), lineWidth: 2)
        default:
            Circle().fill(.clear)
        }
    }
    
    @ViewBuilder
    private var innerSymbol: some View {
        switch state {
        case 1:
            Image(systemName: "checkmark")
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(Color.green)
        case 0:
            Text("-")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.secondary)
        case 2:
            Image(systemName: "ellipsis")
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(Color("customPurple"))
        default:
            EmptyView()
        }
    }
}
