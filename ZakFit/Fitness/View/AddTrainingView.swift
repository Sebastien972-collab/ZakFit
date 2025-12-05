//
//  AddTrainingView.swift
//  ZakFit
//
//  Created by Sébastien Daguin on 04/12/2025.
//


import SwiftUI

struct AddTrainingView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel = AddTrainingViewModel()
    
    var body: some View {
        @Bindable var viewModel = viewModel
        
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    ActivityTypeSection(viewModel: viewModel)
                    DateTimeSection(viewModel: viewModel)
                        .frame(maxWidth: .infinity)
                    DurationSection(viewModel: viewModel)
                    IntensitySection(viewModel: viewModel)
                    CaloriesSection(viewModel: viewModel)
                    NotesSection(viewModel: viewModel)
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .padding(.bottom, 80)
            }
            .navigationTitle("Nouvel entraînement")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                }
            }
            .safeAreaInset(edge: .bottom) {
                BottomButtonBar(viewModel: viewModel) {
                    dismiss()
                }
            }
        }
    }
}

struct ActivityTypeSection: View {
    @Bindable var viewModel: AddTrainingViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Type d’activité")
                .font(.headline)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 3), spacing: 8) {
                ForEach(ActivityType.allCases) { type in
                    let isSelected = viewModel.selectedActivity == type
                    
                    Button {
                        viewModel.selectedActivity = type
                    } label: {
                        VStack(spacing: 8) {
                            Image(systemName: type.iconName)
                                .font(.system(size: 20, weight: .semibold))
                            Text(type.rawValue)
                                .font(.subheadline)
                        }
                        .frame(maxWidth: .infinity, minHeight: 64)
                        .padding(.vertical, 8)
                        .background(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .fill(isSelected ? Color.blue.opacity(0.12)
                                                 : Color(.secondarySystemBackground))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .stroke(isSelected ? Color.blue : .clear, lineWidth: 2)
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .cardStyle()
    }
}

struct DateTimeSection: View {
    @Bindable var viewModel: AddTrainingViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Date et heure")
                .font(.headline)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Date")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                DatePicker(
                    "",
                    selection: $viewModel.date,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.compact)
                .labelsHidden()
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Heure de début")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                DatePicker(
                    "",
                    selection: $viewModel.startTime,
                    displayedComponents: [.hourAndMinute]
                )
                .datePickerStyle(.compact)
                .labelsHidden()
            }
        }
        .cardStyle()
    }
}

struct DurationSection: View {
    @Bindable var viewModel: AddTrainingViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Durée")
                .font(.headline)
            
            Stepper(value: $viewModel.durationMinutes, in: 5...300, step: 5) {
                HStack {
                    Text("\(viewModel.durationMinutes)")
                        .font(.body)
                    Text("minutes")
                        .foregroundStyle(.secondary)
                        .font(.subheadline)
                }
            }
        }
        .cardStyle()
    }
}

struct IntensitySection: View {
    @Bindable var viewModel: AddTrainingViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Intensité")
                .font(.headline)
            
            HStack(spacing: 12) {
                ForEach(Intensity.allCases) { intensity in
                    let isSelected = viewModel.selectedIntensity == intensity
                    
                    Button {
                        viewModel.selectedIntensity = intensity
                    } label: {
                        HStack(spacing: 6) {
                            Image(systemName: "bolt.fill")
                                .font(.caption)
                            Text(intensity.rawValue)
                                .font(.subheadline)
                        }
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .fill(intensity.color.opacity(isSelected ? 0.25 : 0.08))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .stroke(isSelected ? intensity.color : .clear, lineWidth: 2)
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .cardStyle()
    }
}

struct CaloriesSection: View {
    @Bindable var viewModel: AddTrainingViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Calories estimées")
                .font(.headline)
            
            Text("Basé sur votre profil")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(viewModel.estimatedCalories.map { "\($0)" } ?? "--")
                        .font(.title)
                        .fontWeight(.semibold)
                    Text("calories")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                Image(systemName: "flame.fill")
                    .font(.largeTitle)
                    .foregroundStyle(.orange)
            }
            .padding(.top, 8)
        }
        .padding()
        .background(
            LinearGradient(
                colors: [
                    Color.blue.opacity(0.1),
                    Color.purple.opacity(0.1),
                    Color.clear
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .background(Color(.systemBackground))
        )
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 4)
    }
}

struct NotesSection: View {
    @Bindable var viewModel: AddTrainingViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Notes de séance")
                .font(.headline)
            
            TextEditor(text: $viewModel.notes)
                .frame(minHeight: 100)
                .padding(8)
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
        .cardStyle()
    }
}

struct BottomButtonBar: View {
    @Bindable var viewModel: AddTrainingViewModel
    var onSuccess: () -> Void
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.ultraThinMaterial)
                .ignoresSafeArea()
                .frame(height: 80)
            
            Button {
                Task {
                    await viewModel.saveTraining()
                    if viewModel.saveErrorMessage == nil {
                        onSuccess()
                    }
                }
            } label: {
                Text(viewModel.isSaving ? "Enregistrement..." : "Ajouter l’entraînement")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(Color.blue)
                    )
            }
            .disabled(viewModel.isSaving || viewModel.durationMinutes <= 0)
            .padding(.horizontal, 16)
            .padding(.bottom, 12)
        }
    }
}
#Preview {
    AddTrainingView()
}
private extension View {
    func cardStyle() -> some View {
        self
            .padding()
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 4)
    }
}
