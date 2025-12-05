//
//  LastActivityTuileView.swift
//  ZakFit
//
//  Created by Sébastien Daguin on 04/12/2025.
//


import SwiftUI

struct LastActivityTuileView: View {
    let training: TrainingResponse
    
    private var iconName: String {
        // Tu peux ajuster selon tes catégories / noms
        let name = training.activityTypeName.lowercased()
        let category = training.activityTypeCategory.lowercased()
        
        if name.contains("course") || category.contains("run") {
            return "figure.run"
        } else if name.contains("marche") || category.contains("walk") {
            return "figure.walk"
        } else if name.contains("vélo") || name.contains("velo") {
            return "bicycle"
        } else if name.contains("muscu") || category.contains("strength") {
            return "dumbbell.fill"
        } else if name.contains("natation") || name.contains("swim") {
            return "figure.pool.swim"
        } else {
            return "figure.mind.and.body"
        }
    }
    
    private var intensityLabel: String {
        training.intensity
    }
    
    private var intensityColor: Color {
        switch training.intensity.lowercased() {
        case "faible":
            return .green
        case "modérée", "moderee":
            return .yellow
        case "élevée", "elevee":
            return .red
        default:
            return .blue
        }
    }
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: training.date)
    }
    
    private var durationText: String {
        "\(training.durationMinutes) min"
    }
    
    private var caloriesText: String {
        if let cals = training.caloriesBurned {
            return "\(cals) kcal"
        } else {
            return "-- kcal"
        }
    }
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(intensityColor.opacity(0.12))
                    .frame(width: 52, height: 52)
                
                Image(systemName: iconName)
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundStyle(intensityColor)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(training.activityTypeName)
                    .font(.headline)
                
                Text(formattedDate)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                HStack(spacing: 8) {
                    Label(durationText, systemImage: "clock")
                        .font(.caption)
                    Label(caloriesText, systemImage: "flame.fill")
                        .font(.caption)
                }
                .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Text(intensityLabel)
                .font(.caption.bold())
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(
                    Capsule()
                        .fill(intensityColor.opacity(0.15))
                )
                .foregroundStyle(intensityColor)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 10)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(.secondarySystemBackground))
        )
    }
}