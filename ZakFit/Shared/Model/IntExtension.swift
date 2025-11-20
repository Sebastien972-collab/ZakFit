//
//  IntExtension.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 20/11/2025.
//


import Foundation

extension Double {
    
    func roundedFormatted() -> String {
        if self <= 0 {
            return String(self)
        }
        // Convertit l’int en Decimal pour utiliser la même logique interne
        let decimal = Decimal(self)

        var value = decimal
        var result: Decimal = 0

        NSDecimalRound(&result, &value, decimals, .bankers)

        return NSDecimalNumber(decimal: result).stringValu

    }

}
