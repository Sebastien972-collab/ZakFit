//
//  HeaderView.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 17/11/2025.
//

import SwiftUI

struct HeaderView: View {
    let selection: CircleHeader.Selection
    let title: String
    let subtitle: String
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            CircleHeader(selection: selection)
            Text(title)
                .font(.title2)
                .foregroundStyle(.white)
                .fontWeight(.semibold)
            Text(subtitle)
                .font(.title3)
                .foregroundStyle(.white.opacity(0.8))
            
        }
        .frame(maxWidth: .infinity, maxHeight: 200)
    }
}

#Preview {
    HeaderView(selection: .sfImage(systemName: "person.fill"), title: "Bonjour Sébastien", subtitle: "Continuons votre parcours santé")
}
