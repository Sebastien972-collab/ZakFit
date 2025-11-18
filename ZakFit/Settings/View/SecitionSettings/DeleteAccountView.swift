//
//  DeleteAccountView.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 18/11/2025.
//


import SwiftUI

struct DeleteAccountView: View {
    @State private var confirmed = false
    
    var body: some View {
        Form {
            Section {
                Toggle("Je comprends que cette action est définitive", isOn: $confirmed)
                    .tint(.red)
            }
            
            Section {
                Button(role: .destructive) {
                    // Logique de suppression
                } label: {
                    Text("Supprimer mon compte")
                }
                .disabled(!confirmed)
            }
        }
        .navigationTitle("Supprimer le compte")
    }
}

#Preview {
    DeleteAccountView()
}