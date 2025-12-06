//
//  APIConfig.swift
//  FinalSwift
//
//  Created by Gustavo Núñez Duque on 03/12/25.
//


import Foundation

struct AuthPayload: Codable {
    let email: String
    let password: String
    let returnSecureToken: Bool = true
}

struct AuthResponse: Codable {
    let idToken: String
    let email: String
    let localId: String
    let expiresIn: String
}

struct AuthErrorResponse: Decodable {
    let error: AuthErrorDetail
}

struct AuthErrorDetail: Decodable {
    let code: Int
    let message: String
}
