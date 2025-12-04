//
//  HomeView.swift
//  FinalSwift
//
//  Created by Gustavo Núñez Duque on 03/12/25.
//

import SwiftUI

struct HomeView: View {
    // Recibimos el UserViewModel para poder cerrar sesión desde aquí
    var userViewModel: UserViewModel
    
    var body: some View {
        // RT-2: Navegación por Tabs
        TabView {
            // Tab 1: Los Agentes
            AgentsListView()
                .tabItem {
                    Label("Agentes", systemImage: "person.3.fill")
                }
            MapsListView()
                            .tabItem { Label("Mapas", systemImage: "map.fill") }
            WeaponsListView()
                            .tabItem { Label("Armas", systemImage: "scope") }
            ProfileView(viewModel: userViewModel)
                .tabItem {
                    Label("Perfil", systemImage: "gear")
                }
        }
    }
}

#Preview {
    HomeView(userViewModel: UserViewModel())
}
