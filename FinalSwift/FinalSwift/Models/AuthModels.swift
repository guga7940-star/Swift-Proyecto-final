//
//  APIConfig.swift
//  FinalSwift
//
//  Created by Gustavo Núñez Duque on 03/12/25.
//


import Foundation

// Lo que enviamos a Firebase (Login/Registro)
struct AuthPayload: Codable {
    let email: String
    let password: String
    let returnSecureToken: Bool = true
}

// Lo que Firebase nos responde si todo sale bien
struct AuthResponse: Codable {
    let idToken: String
    let email: String
    let localId: String
    let expiresIn: String
}

// Estructuras para capturar errores de Firebase
struct AuthErrorResponse: Decodable {
    let error: AuthErrorDetail
}

struct AuthErrorDetail: Decodable {
    let code: Int
    let message: String
}
