//
//  ExportDataView.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 18/11/2025.
//


import SwiftUI

struct ExportDataView: View {
    @State private var isExporting = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Vous pouvez exporter toutes vos données au format JSON, compatible avec les services courants.")
                .multilineTextAlignment(.center)
                .padding()
            
            Button {
                isExporting = true
            } label: {
                Label("Exporter mes données", systemImage: "square.and.arrow.up")
                    .font(.headline)
            }
            .buttonStyle(.borderedProminent)
            .padding(.top)
        }
        .navigationTitle("Exporter mes données")
    }
}

#Preview {
    ExportDataView()
}
