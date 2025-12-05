struct RecommendationCardView: View {
    let recommendation: ActivityRecommendation
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            ZStack {
                Circle()
                    .fill(recommendation.iconColor.opacity(0.12))
                    .frame(width: 40, height: 40)
                Image(systemName: recommendation.icon)
                    .foregroundColor(recommendation.iconColor)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(recommendation.title)
                    .font(.subheadline.bold())
                Text(recommendation.message)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: Color.black.opacity(0.03), radius: 6, x: 0, y: 2)
    }
}