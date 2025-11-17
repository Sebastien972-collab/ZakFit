//
//  SunsetGradient.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 17/11/2025.
//

import SwiftUI

struct SunsetGradientView: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        if colorScheme != .dark {
            LinearGradient(colors: [Color.lightGold, Color.metallicGold, Color.gold], startPoint: .topLeading, endPoint: .center)
            .edgesIgnoringSafeArea(.all)
        } else {
            LinearGradient(colors: [Color.purple,
                                    Color.customBlue,
                                    Color.pink.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
        }
    }
}

#Preview {
    SunsetGradientView()
}
