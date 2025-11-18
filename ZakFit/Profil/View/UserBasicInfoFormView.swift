//
//  UserBaicInfoFormView.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 18/11/2025.
//

import SwiftUI

struct UserBasicInfoFormView: View {
    @State private var viewModel = UserBasicInfoViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Identité") {
                    TextField("Prénom", text: $viewModel.firstName)
                        .textInputAutocapitalization(.words)
                    
                    TextField("Nom", text: $viewModel.lastName)
                        .textInputAutocapitalization(.words)
                }
                
                Section("Caractéristiques") {
                    TextField("Âge", value: $viewModel.age, format: .number)
                        .keyboardType(.numberPad)

                    TextField("Taille (cm)", value: $viewModel.height, format: .number)
                        .keyboardType(.decimalPad)

                    TextField("Poids (kg)", value: $viewModel.weight, format: .number)
                        .keyboardType(.decimalPad)
                }
            }
            .navigationTitle("Informations de base")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Enregistrer") {
                        viewModel.save()
                        dismiss()
                    }
                }
            }
        }
    }
}
#Preview {
    UserBasicInfoFormView()
}
