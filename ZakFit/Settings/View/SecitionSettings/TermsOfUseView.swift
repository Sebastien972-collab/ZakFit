//
//  TermsOfUseView.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 18/11/2025.
//


import SwiftUI

struct TermsOfUseView: View {
    var body: some View {
        ScrollView {
            Text("""
            Voici les conditions d’utilisation de l’application ZakFit.
            (Texte complet à intégrer ici selon ton contenu légal.)
            """)
            .padding()
        }
        .navigationTitle("Conditions d’utilisation")
    }
}
#Preview {
    TermsOfUseView()
}
