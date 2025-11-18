//
//  DashboardInfoCardView.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 17/11/2025.
//

import SwiftUI

struct InfoCardView: View {
    var body: some View {
        InformationCardView {
            HStack() {
                SingleInformationCardView(sfSymbol: "flame.fill", title: "1,247", subtitle: "Calories", color: .green)
                Spacer()
                SingleInformationCardView(sfSymbol: "dumbbell.fill", title: "45", subtitle: "Minutes", color: .orange)
                Spacer()
                SingleInformationCardView(sfSymbol: "heart.fill", title: "1,247", subtitle: "BPM", color: .red)
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    InfoCardView()
}
