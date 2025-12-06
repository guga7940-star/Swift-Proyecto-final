//
//  ProfileView.swift
//  FinalSwift
//
//  Created by Gustavo Núñez Duque on 04/12/25.
//


import SwiftUI

struct ProfileView: View {
    var viewModel: UserViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundStyle(.gray)
                    .padding(.top, 50)
                
                Text("Usuario Activo")
                    .font(.title2)
                    .bold()
                
                if let email = viewModel.user?.email {
                    Text(email)
                        .foregroundStyle(.secondary)
                } else {
                    Text("Invitado (Modo Prueba)")
                        .foregroundStyle(.orange)
                }
                
                Spacer()
                
                CustomButton(title: "Cerrar Sesión", color: .red) {
                    viewModel.logout()
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
            }
            .navigationTitle("Mi Perfil")
        }
    }
}
