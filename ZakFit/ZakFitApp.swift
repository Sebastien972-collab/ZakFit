//
//  ZakFitApp.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 17/11/2025.
//

import SwiftUI

@main
struct ZakFitApp: App {
    @State private var tabViewModel: TabViewModel = .init()
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environment(tabViewModel)
        }
    }
}
