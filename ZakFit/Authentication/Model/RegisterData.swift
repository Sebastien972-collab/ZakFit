//
//  RegisterRequest.swift
//  ZakFit
//
//  Created by Sébastien DAGUIN on 20/11/2025.
//

import Foundation

struct RegisterData: Codable {
    let firstName: String
    let lastName: String
    let email: String
    let password: String
}
