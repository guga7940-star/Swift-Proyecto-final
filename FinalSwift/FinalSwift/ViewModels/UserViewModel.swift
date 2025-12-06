//
//  UserViewModel.swift
//  FinalSwift
//
//  Created by Gustavo Núñez Duque on 03/12/25.
//

import Foundation
import Observation

@Observable
class UserViewModel {
    var user: AuthResponse? = nil
    var isAuthenticated: Bool = false
    var isLoading: Bool = false
    var errorMessage: String? = nil
    
    private let authService = AuthService.shared
    
    func login(email: String, password: String) async {
        await performAuthAction(email: email, pass: password, action: .signIn)
    }

    func register(email: String, password: String) async { 
        await performAuthAction(email: email, pass: password, action: .signUp)
    }
    
    func logout() {
        user = nil
        isAuthenticated = false
    }
    
    @MainActor
    private func performAuthAction(email: String, pass: String, action: AuthService.AuthAction) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let response = try await authService.authenticate(email: email, pass: pass, action: action)
            self.user = response
            self.isAuthenticated = true
            self.isLoading = false
        } catch {
            self.isLoading = false
            self.errorMessage = error.localizedDescription
        }
    }
    
    func bypassLogin() {
            self.isAuthenticated = true
            self.user = AuthResponse(idToken: "token_falso", email: "test@bypass.com", localId: "123", expiresIn: "3600")
        }
}
