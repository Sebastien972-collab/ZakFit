//
//  ProfilView.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 18/11/2025.
//

import SwiftUI

struct ProfilView: View {
    private var currentUser: User {
        UserManager.shared.currentUser
    }
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    VStack {
                        ZStack {
                            Color.customPurple
                                .frame(height: 200)
                                .frame(maxWidth: .infinity)
                                .ignoresSafeArea(.all)
                            HeaderView(
                                selection: .urlImage(url: URL(string: "https://images.pexels.com/photos/2057435/pexels-photo-2057435.jpeg")!),
                                title: "Bonjour, \(currentUser.firstName)",
                                subtitle: "Assistant Profil ZakFit"
                            )
                        }
                        InformationCardView(title: "Récapitulatif de votre profil", content: {
                            VStack(spacing: 16) {
                                NavigationLink {
                                    GoalSelectionView()
                                } label: {
                                    ProfilNavigationLink(systemName: "target", title: "Objectif principal", subtitle: UserGoal.longTermHealth.rawValue)
                                }
                                NavigationLink {
                                    UserBasicInfoFormView()
                                } label: {
                                    ProfilNavigationLink(systemName: "figure.stand", title: "Information de base", subtitle: "32 ans • \(currentUser.heightCm) cm • \(currentUser.currentWeightKg) kg", color: .customGreen)
                                }
                                NavigationLink {
                                    Text("Selection des objectifs")
                                } label: {
                                    ProfilNavigationLink(systemName: "dumbbell.fill", title: "Niveau d'activité ", subtitle: "Modérément actif", color: .orange)
                                }
                            }
                        })
                        .offset(y: -16)
                        .padding(.horizontal)
                    }
                    
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink {
                            SettingsView()
                        } label: {
                            Image(systemName: "gearshape.fill")
                        }

                    }
                }
            }
        }
    }
}

#Preview {
    ProfilView()
}
