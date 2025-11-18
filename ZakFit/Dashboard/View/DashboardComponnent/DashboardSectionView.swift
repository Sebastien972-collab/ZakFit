//
//  DashboardSection.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 18/11/2025.
//

import SwiftUI

struct DashboardSectionView<Content: View, Destination: View>: View {
    let title: String
    let content: Content
    let navigationLink: String
    let destination: Destination?

    // MARK: - Init sans navigation
    init(
        title: String,
        navigationLink: String = "Voir tout",
        @ViewBuilder content: () -> Content
    ) where Destination == EmptyView {
        self.title = title
        self.navigationLink = navigationLink
        self.destination = nil
        self.content = content()
    }

    // MARK: - Init avec navigation
    init(
        title: String,
        navigationLink: String = "Voir tout",
        @ViewBuilder destination: () -> Destination,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.navigationLink = navigationLink
        self.destination = destination()
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(title)
                    .font(.title2)
                    .fontWeight(.semibold)

                Spacer()

                if let destination {
                    NavigationLink(destination: destination) {
                        Text(navigationLink)
                            .fontWeight(.semibold)
                            .foregroundColor(.suggestionPurple)
                    }
                }
            }
            .padding(.horizontal, 16)

            content
                .padding(.horizontal, 16)
        }
    }
}

#Preview {
    NavigationStack {
        DashboardSectionView(title: "Actions Rapide") {
            Grid(alignment: .center, horizontalSpacing: 15, verticalSpacing: 15) {
                GridRow {
                    QuickActionButton(
                        sfSymbol: "fork.knife",
                        title: "Ajouter un repas",
                        color: .green,
                        action: {}
                    )

                    QuickActionButton(
                        sfSymbol: "figure.run",
                        title: "Entraînement",
                        color: .suggestionPurple,
                        action: {}
                    )
                }

                GridRow {
                    QuickActionButton(
                        sfSymbol: "figure.stand.line.dotted.figure.stand",
                        title: "Poids",
                        color: .orange,
                        action: {}
                    )

                    QuickActionButton(
                        sfSymbol: "chart.line.uptrend.xyaxis",
                        title: "Progrès",
                        color: .blue,
                        action: {}
                    )
                }
            }
        }
        DashboardSectionView(title: "Repas récent") {
            Text("Tous les repas seront affichés ici.")
        } content: {
            Text("Les repas")
                .padding(.horizontal)
        }
    }
}
