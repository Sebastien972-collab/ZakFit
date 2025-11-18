//
//  SupportView.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 18/11/2025.
//


import SwiftUI

struct SupportView: View {
    var body: some View {
        Form {
            Section("Contact") {
                Link(destination: URL(string: "mailto:support@zakfit.com")!) {
                    Label("Envoyer un email", systemImage: "envelope")
                }
                
                Link(destination: URL(string: "https://zakfit.com/support")!) {
                    Label("Centre d’aide", systemImage: "questionmark.circle")
                }
            }
            
            Section("Informations") {
                Text("ZakFit Assistance\nDisponible 7j/7")
            }
        }
        .navigationTitle("Support")
    }
}
#Preview {
    SupportView()
}
