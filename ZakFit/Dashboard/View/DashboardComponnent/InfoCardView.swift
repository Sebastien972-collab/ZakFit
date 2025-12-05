//
//  DashboardInfoCardView.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 17/11/2025.
//

import SwiftUI

struct InfoCardView: View {
    @State private var snapshot: HealthSnapshot = .init(steps: 0, activeEnergy: 0, exerciseMinutes: 0, workouts: [])
    @State private var minutes: Int = 0
    var body: some View {
        InformationCardView {
            HStack() {
                SingleInformationCardView(sfSymbol: "flame.fill", title: Int(snapshot.steps).description, subtitle: "Calories", color: .green)
                Spacer()
                SingleInformationCardView(sfSymbol: "dumbbell.fill", title: minutes.description, subtitle: "Minutes", color: .orange)
                Spacer()
                SingleInformationCardView(sfSymbol: "heart.fill", title: "1,247", subtitle: "BPM", color: .red)
            }
            .padding(.horizontal)
        }
        .task {
            do {
                let stepCount = try await HealthKitManager.shared.stepsToday()
                let activeEnergyBurned = try await HealthKitManager.shared.activeEnergyToday()
                let workouts = try await HealthKitManager.shared.workouts()
                minutes = Int(try await HealthKitManager.shared.exerciseMinutesToday())
                let snap = HealthSnapshot(steps: stepCount, activeEnergy: activeEnergyBurned, exerciseMinutes: 9, workouts: workouts)
                
                self.snapshot = snap
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    InfoCardView()
}
