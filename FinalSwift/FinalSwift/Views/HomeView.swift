//
//  HomeView.swift
//  FinalSwift
//
//  Created by Gustavo Núñez Duque on 03/12/25.
//

import SwiftUI

struct HomeView: View {
    var userViewModel: UserViewModel
    
    init(userViewModel: UserViewModel) {
        self.userViewModel = userViewModel
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
        .tint(.valRed)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    HomeView(userViewModel: UserViewModel())
}
