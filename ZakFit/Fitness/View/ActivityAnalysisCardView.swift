// MARK: - Analyse carte principale

struct ActivityAnalysisCardView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 8) {
                Image(systemName: "chart.bar.xaxis")
                    .foregroundColor(.blue)
                Text("Analyse de votre activité")
                    .font(.headline)
                Spacer()
            }
            
            Text("Aperçu : Vous avez un niveau d’activité modéré cette semaine avec 3 jours actifs sur 5. Vous êtes en bonne voie, mais il reste de la marge pour améliorer votre régularité !")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            // Points positifs
            PositivePointsView()
            
            // À améliorer
            ImprovementPointsView()
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 4)
        .padding(.horizontal)
    }
}

struct PositivePointsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 8) {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
                Text("Points positifs :")
                    .font(.subheadline.bold())
            }
            
            VStack(alignment: .leading, spacing: 4) {
                bullet("Bonne constance en début de semaine")
                bullet("Vous avez atteint 62% de votre objectif de pas")
                bullet("Mélange de marche et d’activités variées")
            }
            .font(.footnote)
        }
        .padding()
        .background(Color.green.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
    }
    
    private func bullet(_ text: String) -> some View {
        HStack(alignment: .top, spacing: 6) {
            Text("•")
            Text(text)
        }
    }
}

struct ImprovementPointsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 8) {
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundColor(.orange)
                Text("À améliorer :")
                    .font(.subheadline.bold())
            }
            
            VStack(alignment: .leading, spacing: 4) {
                bullet("2 jours d’inactivité cette semaine")
                bullet("Durée des séances à augmenter légèrement")
                bullet("Pas d’entraînement de renforcement musculaire")
            }
            .font(.footnote)
        }
        .padding()
        .background(Color.orange.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
    }
    
    private func bullet(_ text: String) -> some View {
        HStack(alignment: .top, spacing: 6) {
            Text("•")
            Text(text)
        }
    }
}