//
//  CustomSecureField.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 19/11/2025.
//

import SwiftUI
struct CustomSecureField: View {
    let title: String
    var placeholder: String? = nil
    @Binding var text: String
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .fontWeight(.regular)
            HStack {
                SecureField(placeholder ?? "", text: $text)
                Image(systemName: "lock.fill")
                    .frame(width: 16, height: 16)
                    .foregroundStyle(.gray)
                    .background(.black.opacity(0))
                    .overlay(
                    Rectangle()
                    .stroke(Color(red: 0.9, green: 0.91, blue: 0.92), lineWidth: 0)
                    )
                    
            }
            .padding(.horizontal)
            .frame(height: 58, alignment: .trailing)
            .background {
                Color.white
            }
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay {
                RoundedRectangle(cornerRadius: 16)
                    .inset(by: 0.5)
                    .stroke(Color(red: 0.9, green: 0.91, blue: 0.92) ,lineWidth: 1)
            }
        }
        
        .frame(maxWidth: .infinity)
    }
}


#Preview {
    CustomSecureField(title: "Mot de passe", text: .constant(""))
        .padding(.horizontal)
}
