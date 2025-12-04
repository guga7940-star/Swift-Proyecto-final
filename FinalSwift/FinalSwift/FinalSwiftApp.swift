//
//  FinalSwiftApp.swift
//  FinalSwift
//
//  Created by Gustavo Núñez Duque on 02/12/25.
//

import SwiftUI

@main
struct FinalSwiftApp: App {
    @State private var userViewModel = UserViewModel()
    
    var body: some Scene {
        WindowGroup {
            if userViewModel.isAuthenticated {
                // CAMBIA ESTO:
                HomeView(userViewModel: userViewModel)
            } else {
                LoginView(viewModel: userViewModel)
            }
        }
    }
}
