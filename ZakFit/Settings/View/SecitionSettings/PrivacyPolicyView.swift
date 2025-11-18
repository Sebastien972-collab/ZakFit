//
//  PrivacyPolicyView.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 18/11/2025.
//


import SwiftUI

struct PrivacyPolicyView: View {
    var body: some View {
        ScrollView {
            Text("""
            Voici la politique de confidentialité de ZakFit.
            (Texte officiel à intégrer ici.)
            """)
            .padding()
        }
        .navigationTitle("Confidentialité")
    }
}
#Preview {
    PrivacyPolicyView()
}
