//
//  QuickActionButton.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 17/11/2025.
//

import SwiftUI

struct QuickActionButton: View {
    let sfSymbol: String
    let title: String
    var color: Color = .red
    let action: () -> Void
    var body: some View {
        Button {
            action()
        } label: {
            InformationCardView {
                VStack {
                    ImageAndCircleView(sfSymbol: sfSymbol, color: color)
                    Text(title)
                        .foregroundColor(Color(red: 0.07, green: 0.09, blue: 0.15))
                        .fontWeight(.medium)
                }
            }
            .frame(maxWidth: 200, maxHeight: 150)
        }
       

    }
}

#Preview {
    QuickActionButton(sfSymbol: "fork.knife", title: "Ajouter un repas", action: {})
}
