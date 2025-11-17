//
//  CircleHeader.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 17/11/2025.
//

import SwiftUI

struct CircleHeader: View {
    enum Selection {
        case sfImage(systemName: String)
        case urlImage(url: URL)
    }
    
    var selection: Selection
    
    var body: some View {
        ZStack {
            // Fond "verre" circulaire
            Circle()
                .fill(Color.white.opacity(0.18))
                .overlay(
                    Circle()
                        .stroke(Color.white.opacity(0.4), lineWidth: 1)
                )
            
            contentView
        }
        .frame(width: 64, height: 64)
        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
    }
    
    @ViewBuilder
    private var contentView: some View {
        switch selection {
        case .sfImage(let systemName):
            Image(systemName: systemName)
                .font(.system(size: 26, weight: .semibold))
                .symbolRenderingMode(.hierarchical)
                .foregroundStyle(Color.white)
            
        case .urlImage(let url):
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .tint(.white)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                case .failure:
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 26, weight: .medium))
                        .foregroundStyle(.white.opacity(0.9))
                @unknown default:
                    EmptyView()
                }
            }
        }
    }
}

#Preview {
    ZStack {
        Color.black.opacity(0.9).ignoresSafeArea()
        
        VStack(spacing: 24) {
            CircleHeader(selection: .urlImage(url: URL(string: "https://images.pexels.com/photos/2057435/pexels-photo-2057435.jpeg")!))
            CircleHeader(selection: .sfImage(systemName: "dumbbell.fill"))
        }
    }
}
