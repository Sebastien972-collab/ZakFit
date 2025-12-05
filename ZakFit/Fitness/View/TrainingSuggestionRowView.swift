struct TrainingSuggestionRowView: View {
    let suggestion: TrainingSuggestion
    
    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(suggestion.iconColor.opacity(0.12))
                    .frame(width: 40, height: 40)
                Image(systemName: suggestion.icon)
                    .foregroundColor(suggestion.iconColor)
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(suggestion.title)
                    .font(.subheadline.bold())
                Text(suggestion.subtitle)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 2) {
                Text(suggestion.durationText)
                    .font(.subheadline.bold())
                Text(suggestion.caloriesText)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: Color.black.opacity(0.03), radius: 6, x: 0, y: 2)
    }
}