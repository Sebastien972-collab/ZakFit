//
//  DateExtension.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 18/11/2025.
//

import Foundation

extension Date {
    func hourMinuteFormatted() -> String {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: self)
        let minute = calendar.component(.minute, from: self)
        
        return String(format: "%dh%02d", hour, minute)
    }
}
