//
//  DoubleExtension.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 24/11/2025.
//


import Foundation

extension Double {
    func roundedFormatted(decimals: Int = 1) -> String {
        String(format: "%.\(decimals)f", self)
    }
}
