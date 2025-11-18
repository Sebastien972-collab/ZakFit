//
//  ProfilNavigationLink.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 18/11/2025.
//

import SwiftUI

struct ProfilNavigationLink: View {
    let systemName: String
    let title: String
    let subtitle: String
    var color: Color = .customLightBlue
    var body: some View {
        HStack {
            ImageAndCircleView(sfSymbol: systemName, color: color)
            VStack(alignment: .leading) {
                Text(title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                Text(subtitle)
                    .fontWeight(.light)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .foregroundStyle(.black)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundStyle(.black)
                .fontWeight(.semibold)
        }
    }
}

#Preview {
    ProfilNavigationLink(systemName: "target", title: "Objectif principal", subtitle: UserGoal.weightLossGradual.rawValue)
}
