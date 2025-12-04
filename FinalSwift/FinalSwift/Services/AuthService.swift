//
//  AuthService.swift
//  FinalSwift
//
//  Created by Gustavo Núñez Duque on 03/12/25.
//


import Foundation

class AuthService {
    
    static let shared = AuthService()
    
    enum AuthAction {
        case signUp
        case signIn
        
        var urlString: String {
            let base = APIConfig.authBaseURL
            let key = APIConfig.firebaseKey
            switch self {
            case .signUp: return "\(base):signUp?key=\(key)"
            case .signIn: return "\(base):signInWithPassword?key=\(key)"
            }
        }
    }
    
    func authenticate(email: String, pass: String, action: AuthAction) async throws -> AuthResponse {
        
        guard let url = URL(string: action.urlString) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let payload = AuthPayload(email: email, password: pass)
        request.httpBody = try JSONEncoder().encode(payload)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        // Manejo de errores (RT-7)
        if !(200...299).contains(httpResponse.statusCode) {
            if let errorResponse = try? JSONDecoder().decode(AuthErrorResponse.self, from: data) {
                throw NSError(domain: "Auth", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: errorResponse.error.message])
            }
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(AuthResponse.self, from: data)
    }
}
