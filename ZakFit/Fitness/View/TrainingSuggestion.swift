struct TrainingSuggestion: Identifiable {
    let id = UUID()
    let icon: String
    let iconColor: Color
    let title: String
    let subtitle: String
    let durationText: String
    let caloriesText: String
}