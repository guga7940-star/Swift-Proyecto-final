//
//  HomeView.swift
//  FinalSwift
//
//  Created by Gustavo Núñez Duque on 03/12/25.
//

import SwiftUI

struct HomeView: View {
    var userViewModel: UserViewModel
    
    // Configuramos el aspecto de la TabBar al iniciar
    init(userViewModel: UserViewModel) {
        self.userViewModel = userViewModel
        // Hacer la barra de tabs oscura
        UITabBar.appearance().backgroundColor = UIColor(Color.valDark)
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray
    }
    
    var body: some View {
        TabView {
            AgentsListView()
                .tabItem { Label("AGENTES", systemImage: "person.3.fill") }
            
            MapsListView()
                .tabItem { Label("MAPAS", systemImage: "map.fill") }
            
            WeaponsListView()
                .tabItem { Label("ARSENAL", systemImage: "scope") }
            
            ProfileView(viewModel: userViewModel)
                .tabItem { Label("PERFIL", systemImage: "gear") }
        }
        .tint(.valRed) // El icono seleccionado se pone rojo
        .preferredColorScheme(.dark) // Fuerza modo oscuro en toda la app
    }
}

#Preview {
    HomeView(userViewModel: UserViewModel())
}
